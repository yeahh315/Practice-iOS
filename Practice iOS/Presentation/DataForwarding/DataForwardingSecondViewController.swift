//
//  DataForwardingSecondViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/28.
//

import UIKit

class DataForwardingSecondViewController: UIViewController {

    // MARK: - Properties

    private let mainLabel = UILabel()
    private let backButton = UIButton()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
        printNavigationController()
    }
    
    // MARK: - Methods
    
    private func setStyle() {
        
        view.backgroundColor = .systemGray6
        
        mainLabel.do {
            $0.text = "안녕하시와요 (데이터 전달)🤗"
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textAlignment = .center
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
        
        view.addSubviews(mainLabel, backButton)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(backButton.snp.top).offset(-20)
        }
        
        backButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(156)
            $0.center.equalToSuperview()
        }
    }
    
    private func printNavigationController() {
        print("navigationController 정보 : ", self.navigationController ?? "없어용")
    }
    
    @objc private func backButtonDidTap() {
//        self.presentingViewController?.dismiss(animated: true)
//        self.dismiss(animated: true)
        if (self.navigationController == nil) {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
