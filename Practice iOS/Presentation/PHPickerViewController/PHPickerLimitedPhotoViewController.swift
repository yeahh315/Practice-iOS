//
//  PHPickerLimitedPhotoViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/07/11.
//

import UIKit
import Photos


class PHPickerLimitedPhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    private let imageSpacing: CGFloat = 4
    
    private var imageDummy = [UIImage]()
    
    var fetchResult = PHFetchResult<PHAsset>()
        var thumbnailSize: CGSize {
            let scale = UIScreen.main.scale
            return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
        }
    
    // MARK: - UI Properties
    
    private lazy var limitedPhotoCollectionView: UICollectionView = {
        let imageSize = (screenWidth - imageSpacing * 2) / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: imageSize, height: imageSize)
        flowLayout.minimumLineSpacing = imageSpacing
        flowLayout.minimumInteritemSpacing = imageSpacing
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(PHPickerLimitedPhotoCollectionViewCell.self, forCellWithReuseIdentifier: PHPickerLimitedPhotoCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.shared().register(self)

        setupNavigationItem()
        setStyle()
        setLayout()
    }
}

extension PHPickerLimitedPhotoViewController {
    
    // MARK: - Methods
    
    private func setStyle() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(limitedPhotoCollectionView)
        
        limitedPhotoCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavigationItem() {
        let add = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addButtonDidTap))
        self.navigationItem.rightBarButtonItem = add
    }
    
    func setImageDummy(forImage: [UIImage]) {
        imageDummy = forImage
    }
    
    func reload() {
        limitedPhotoCollectionView.reloadData()
    }
    
    @objc
    func addButtonDidTap() {
        selectLimited()
    }
    
    func selectLimited() {
        //        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
        DispatchQueue.main.async {
            
            let title: String = "pophory -ios 이(가) 사용자의 사진에 접근하려고 합니다."
            let message: String = "앱에 사진을 업로드하기 위해 사진 라이브러리에 엑세스를 허용합니다."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirm = UIAlertAction(title: "더 많은 사진 선택", style: .default) { (UIAlertAction) in
                PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
                self.setLimited()
            }
            let cancle = UIAlertAction(title: "현재 선택 항목 유지", style: .default) { (UIAlertAction) in
                self.dismiss(animated: true)
            }
            
            alert.addAction(confirm)
            alert.addAction(cancle)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setLimited() {
        
        self.imageDummy = []
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        self.fetchResult.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: self.thumbnailSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
                guard let image = image else { return }
                self.imageDummy.append(image)
                DispatchQueue.main.async {
                    self.reload()
                }
            }
        }
        
    }
}

extension PHPickerLimitedPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PHPickerLimitedPhotoCollectionViewCell.identifier, for: indexPath) as? PHPickerLimitedPhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(image: imageDummy[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = PHPickerSecondViewController()
        secondViewController.setImage(forImage: imageDummy[indexPath.item])
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension PHPickerLimitedPhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.setLimited()
    }
}
