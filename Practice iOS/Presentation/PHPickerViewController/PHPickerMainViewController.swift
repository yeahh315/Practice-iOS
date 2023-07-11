//
//  PHPickerMainViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/07/11.
//

import UIKit

import Photos
import PhotosUI
import SnapKit
import Then

class PHPickerMainViewController: UIViewController {
    
//    var fetchResult = PHFetchResult<PHAsset>()
//    var canAccessImages: [UIImage] = []
//    var thumbnailSize: CGSize {
//        let scale = UIScreen.main.scale
//        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
//    }
    let limitedViewController = PHPickerLimitedPhotoViewController()
    
    
    // MARK: - PHPickerViewController 적용
    
//    let phpickerViewController: PHPickerViewController = {
//        var configuration = PHPickerConfiguration()
//        configuration.selectionLimit = 1 // 최대로 선택할 사진 및 영상의 개수
//
//        // 라이브에 접근할 때 적용될 필터
//        /// images, livePhotos, videos, any 존재함
//        configuration.filter = .images
//
//        let picker = PHPickerViewController(configuration: configuration)
//        return picker
//    }()
    
    private func setDelegate() {
        BasePHPickerViewController.shared.phpickerViewController.delegate = self
        let confirm = UIAlertAction(title: "더 많은 사진 선택", style: .default) { (UIAlertAction) in
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
        }
        let cancle = UIAlertAction(title: "현재 선택 항목 유지", style: .default) { (UIAlertAction) in
            self.setLimited()
        }

        BasePHPickerViewController.shared.limitedAlert.addAction(confirm)
        BasePHPickerViewController.shared.limitedAlert.addAction(cancle)
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

        let requiredAccessLevel: PHAccessLevel = .readWrite
        PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                self.presentImage()
            case .limited:
                self.setLimited()
            case .denied:
                self.AuthSettingOpen()
            default:
                break
            }
        }
    }
    
    func presentImage() {
        DispatchQueue.main.async {
            self.present(BasePHPickerViewController.shared.phpickerViewController, animated: true)
        }
    }
    
    func AuthSettingOpen() {
        DispatchQueue.main.async {
            self.present(BasePHPickerViewController.shared.deniedAlert, animated: true, completion: nil)
        }
    }
    
    func selectLimited() {
        DispatchQueue.main.async {
            self.present(BasePHPickerViewController.shared.limitedAlert, animated: true, completion: nil)
        }
    }
    
    func setLimited() {
        DispatchQueue.main.async {
            self.limitedViewController.setImageDummy(forImage: BasePHPickerViewController.shared.setLimited())

            self.navigationController?.pushViewController(self.limitedViewController, animated: true)
        }
    }
    
    
    // MARK: - @objc Function
    
    @objc private func onClickedNextButton() {
        setupImagePermission()
    }
    
}

