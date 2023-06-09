//
//  NavigationViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/09.
//

import UIKit

class NavigationMainViewController: UIViewController {

    // MARK: - Properties
    
    private let navigationButton = UIButton()
    private let stateLabel = UILabel()
    
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
        
        view.backgroundColor = .white
        
        navigationButton.do {
            $0.setTitle("다음으로", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemCyan
            $0.makeRounded(radius: 5)
            $0.addTarget(self, action: #selector(navigationButtonDidTap), for: .touchUpInside)
        }
        
        stateLabel.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
    }
    
    private func setLayout() {
        
        view.addSubviews(stateLabel, navigationButton)
        
        stateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        navigationButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(200)
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

    // MARK: - @objc Function
    
    @objc private func navigationButtonDidTap() {
        let secondViewController = NavigationSecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

}
