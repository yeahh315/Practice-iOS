//
//  SceneSecondViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/07.
//

import UIKit

import SnapKit
import Then

class SceneSecondViewController: UIViewController {

    // MARK: - Properties

    private let mainLabel = UILabel()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
    }
    
    // MARK: - Methods
    
    private func setStyle() {
        
        view.backgroundColor = .systemGray6
        
        mainLabel.do {
            $0.text = "안녕하시와요 🤗"
            $0.font = .boldSystemFont(ofSize: 12)
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        
        view.addSubviews(mainLabel)
        
        mainLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
