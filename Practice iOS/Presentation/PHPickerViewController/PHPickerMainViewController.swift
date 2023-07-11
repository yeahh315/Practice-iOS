//
//  PHPickerMainViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/07/11.
//

import UIKit

import PhotosUI
import SnapKit
import Then

class PHPickerMainViewController: UIViewController {
    
    // MARK: - PHPickerViewController 적용
    
    let phpickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 // 최대로 선택할 사진 및 영상의 개수
        
        // 라이브에 접근할 때 적용될 필터
        /// images, livePhotos, videos, any 존재함
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        return picker
    }()
    
    private func setDelegate() {
        phpickerViewController.delegate = self
    }
    
    
    // MARK: - UI Properties
    
    private lazy var nextButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setLayout()
        setDelegate()
    }
    
}

extension PHPickerMainViewController: PHPickerViewControllerDelegate {
    
    // 이미지 선택 완료 시 호출될 함수
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil) // 갤러리 dismiss
        
        let itemProvider = results.first?.itemProvider // result의 첫 번째 배열의 값 - ‼️ itemProvider
        
        if let itemProvider = itemProvider,                     // itemProvider가 존재하고,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // itemProvider가 불러온 이미지 값 가져올 수 있다면 실행
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                
                DispatchQueue.main.async {
                    guard let selectedImage = image as? UIImage else { return }
                    let secondViewController = PHPickerSecondViewController()
                    secondViewController.setImage(forImage: selectedImage)
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
            }
        }
    }
}

extension PHPickerMainViewController {
    
    // MARK: - Methods
    
    private func setStyle() {
        
        view.backgroundColor = .white
        
        nextButton.do {
            $0.setTitle("이미지 선택하기", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(onClickedNextButton), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.width.equalTo(156)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupImagePermission() {
//        PHPhotoLibrary.requestAuthorization({ status in
//            switch status{
//            case .authorized:
//                self.presentImage()
//            case .limited:
//                self.selectLimited()
//            case .denied:
//                self.AuthSettingOpen()
//            default:
//                break
//            }
//        })
        let requiredAccessLevel: PHAccessLevel = .readWrite
        PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                self.presentImage()
            case .limited:
                self.selectLimited()
            case .denied:
                self.AuthSettingOpen()
            default:
                break
            }
        }
    }
    
    func presentImage() {
        DispatchQueue.main.async {
            self.present(self.phpickerViewController, animated: true)
        }
    }
    
    func AuthSettingOpen() {
        DispatchQueue.main.async {
            let titleMessage: String = "사진을 업로드하기 위해 설정을 눌러 사진 접근을 허용해주세요."
            let alert = UIAlertController(title: titleMessage, message: nil, preferredStyle: .alert)
            
            let cancle = UIAlertAction(title: "확인", style: .default)
            let confirm = UIAlertAction(title: "설정", style: .default) { (UIAlertAction) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            
            alert.addAction(cancle)
            alert.addAction(confirm)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func selectLimited() {
//        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
        DispatchQueue.main.async {
            
            let title: String = "pophory -ios 이(가) 사용자의 사진에 접근하려고 합니다."
            let message: String = "앱에 사진을 업로드하기 위해 사진 라이브러리에 엑세스를 허용합니다."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "더 많은 사진 선택", style: .default) { (UIAlertAction) in
                PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
            }
            let cancle = UIAlertAction(title: "현재 선택 항목 유지", style: .default) { (UIAlertAction) in
                
            }
            
            alert.addAction(confirm)
            alert.addAction(cancle)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - @objc Function
    
    @objc private func onClickedNextButton() {
        setupImagePermission()
    }
}
