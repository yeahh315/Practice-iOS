//
//  BasePHPickerViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/07/11.
//

import UIKit

import PhotosUI

class BasePHPickerViewController {

    static let shared = BasePHPickerViewController()

    var fetchResult = PHFetchResult<PHAsset>()
    var canAccessImages: [UIImage] = []
    var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
    }

    let phpickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 // 최대로 선택할 사진 및 영상의 개수

        // 라이브에 접근할 때 적용될 필터
        /// images, livePhotos, videos, any 존재함
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        return picker
    }()
    
    let deniedAlert: UIAlertController = {
        let titleMessage: String = "사진을 업로드하기 위해 설정을 눌러 사진 접근을 허용해주세요."
        let alert = UIAlertController(title: titleMessage, message: nil, preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "확인", style: .default)
        let confirm = UIAlertAction(title: "설정", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        
        alert.addAction(cancle)
        alert.addAction(confirm)
        return alert
    }()
    
    let limitedAlert: UIAlertController = {
        let title: String = "pophory -ios 이(가) 사용자의 사진에 접근하려고 합니다."
        let message: String = "앱에 사진을 업로드하기 위해 사진 라이브러리에 엑세스를 허용합니다."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        return alert
    }()

//    func setupImagePermission() {
//
//        let requiredAccessLevel: PHAccessLevel = .readWrite
//        PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
//            switch authorizationStatus {
//            case .authorized:
//                self.presentImage()
//            case .limited:
//                self.setLimited()
//            case .denied:
//                self.AuthSettingOpen()
//            default:
//                break
//            }
//        }
//    }


    

    

    func setLimited() -> [UIImage] {

        self.canAccessImages = []
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true

        let fetchOptions = PHFetchOptions()
        self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        self.fetchResult.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: self.thumbnailSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
                guard let image = image else { return }
                self.canAccessImages.append(image)

            }
        }
        
        return canAccessImages
    }
}

