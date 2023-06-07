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
    private let dismissButton = UIButton()

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
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textAlignment = .center
        }
        
        dismissButton.do {
            $0.setTitle("모달을 dismiss", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemPurple
            $0.makeRounded(radius: 5)
            $0.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        
        view.addSubviews(mainLabel, dismissButton)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(dismissButton.snp.top).offset(-20)
        }
        
        dismissButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(156)
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func dismissButtonDidTap() {
//        self.presentingViewController?.dismiss(animated: true)
        self.dismiss(animated: true)
    }
}
