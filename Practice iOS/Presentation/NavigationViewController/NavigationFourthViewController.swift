//
//  NavigationFourthViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/10.
//

import UIKit

class NavigationFourthViewController: UIViewController {

    // MARK: - Properties

    private let mainLabel = UILabel()
    private let stateLabel = UILabel()
    private let backButton = UIButton()
    private let backToStartButton = UIButton()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getViewController()
    }
    
    // MARK: - Methods
    
    private func setStyle() {
        
        view.backgroundColor = .systemGray6
        
        mainLabel.do {
            $0.text = "안녕하시와요 🤗"
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textAlignment = .center
        }
        
        stateLabel.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        backButton.do {
            $0.setTitle("뒤로가기", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemPurple
            $0.makeRounded(radius: 5)
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        backToStartButton.do {
            $0.setTitle("처음으로", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemRed
            $0.makeRounded(radius: 5)
            $0.addTarget(self, action: #selector(backToStartButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        
        view.addSubviews(mainLabel, stateLabel, backButton, backToStartButton)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stateLabel.snp.top).offset(-20)
        }
        
        stateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(backButton.snp.top).offset(-20)
        }
        
        backButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(200)
            $0.center.equalToSuperview()
        }
        
        backToStartButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backButton.snp.bottom).offset(20)
        }
    }
    
    private func getViewController() {
        let topVC = self.navigationController?.topViewController?.description.components(separatedBy: ".").last ?? ""
        let visibleVC = self.navigationController?.visibleViewController?.description.components(separatedBy: ".").last ?? ""
        stateLabel.text = "topVC : \(topVC)\nvisibleVC : \(visibleVC)"
        
        print(self.navigationController?.viewControllers ?? "없어용")
    }
    
    @objc private func backButtonDidTap() {
        
        if (self.navigationController == nil) {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func backToStartButtonDidTap() {
        
        if (self.navigationController == nil) {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
