//
//  SceneMainViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/07.
//

import UIKit

import SnapKit
import Then


class SceneMainViewController: UIViewController {
    
    // MARK: - Properties

    private let modalButton = UIButton()
    private let navigationButton = UIButton()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
    }
    
    // MARK: - Methods
    
    private func setStyle() {
        
        view.backgroundColor = .white
        
        modalButton.do {
            $0.setTitle("Modal - present", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.makeRounded(radius: 5)
            $0.addTarget(self, action: #selector(modalButtonDidTap), for: .touchUpInside)
        }
        
        navigationButton.do {
            $0.setTitle("Navigation Controller - Push", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemCyan
            $0.makeRounded(radius: 5)
            $0.addTarget(self, action: #selector(navigationButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        
        view.addSubviews(modalButton,
                         navigationButton)
        
        modalButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(navigationButton.snp.top).offset(-20)
        }
        
        navigationButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(200)
            $0.center.equalToSuperview()
        }
    }
    
    private func changeButtonTitle() {
        modalButton.do {
            $0.setTitle("다시 띄우실겨?", for: .normal)
        }
    }
    
    // MARK: - @objc Function

    @objc private func modalButtonDidTap() {
        let secondViewController = SceneSecondViewController()
//        secondViewController.modalTransitionStyle = .flipHorizontal
//        secondViewController.modalPresentationStyle = .fullScreen
//        secondViewController.modalPresentationCapturesStatusBarAppearance = false
//        secondViewController.isModalInPresentation = false
        self.present(secondViewController, animated: true, completion: changeButtonTitle)
    }
    
    @objc private func navigationButtonDidTap() {
        let secondViewController = SceneSecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
