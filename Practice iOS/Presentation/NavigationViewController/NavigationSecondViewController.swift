//
//  NavigationSecondViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/10.
//

import UIKit

class NavigationSecondViewController: UIViewController {

    // MARK: - Properties

    private let mainLabel = UILabel()
    private let stateLabel = UILabel()
    private let backButton = UIButton()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
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
    }
    
    private func setLayout() {
        
        view.addSubviews(mainLabel, stateLabel, backButton)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stateLabel.snp.top).offset(-20)
        }
        
        stateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(156)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stateLabel.snp.bottom).offset(20)
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
}
