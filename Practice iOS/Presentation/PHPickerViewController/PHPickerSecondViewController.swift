//
//  PHPickerSecondViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/07/11.
//

import UIKit

class PHPickerSecondViewController: UIViewController {

    // MARK: - UI Properties

    private let imageView = UIImageView()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setLayout()
    }
}

extension PHPickerSecondViewController {
    
    // MARK: - Methods
    
    private func setStyle() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(200)
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
    }
    
    func setImage(forImage: UIImage) {
        imageView.image = forImage
    }
    

}
