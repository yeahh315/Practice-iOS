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
    
    let limitedViewController = PHPickerLimitedPhotoViewController()
    let phpickerViewController = BasePHPickerViewController()
        
    // MARK: - UI Properties
    
    private lazy var nextButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setLayout()
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
    
    // MARK: - @objc Function
    
    @objc private func onClickedNextButton() {
        phpickerViewController.setupImagePermission()
    }
    
}

extension PHPickerMainViewController: PHPickerProtocol {
    
    func setupPicker() {
        DispatchQueue.main.async {
            guard let selectedImage = self.phpickerViewController.pickerImage else { return }
            let secondViewController = PHPickerSecondViewController()
            secondViewController.setImage(forImage: selectedImage)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    func presentLimitedLibrary() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    func presentImageLibrary() {
        DispatchQueue.main.async {
            self.present(self.phpickerViewController.phpickerViewController, animated: true)
        }
    }
    
    func presentDenidAlert() {
        DispatchQueue.main.async {
            self.present(self.phpickerViewController.deniedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedAlert() {
        DispatchQueue.main.async {
            self.present(self.phpickerViewController.limitedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedImageView() {
        DispatchQueue.main.async {
            self.limitedViewController.setImageDummy(forImage: self.phpickerViewController.fetchLimitedImages())

            self.navigationController?.pushViewController(self.limitedViewController, animated: true)
        }
    }
}
