//
//  PropertyViewController.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/05.
//

import UIKit

import SnapKit
import Then

class PropertyViewController: UIViewController {

    private var hitCount: Int = 0 {
            didSet(oldHitCount) {
                if (hitCount > 0) {
                    countPresentLabel.text = "현재 생성된 번호 : \(hitCount)"
                    if (oldHitCount != 0) {
                        countOldLabel.text = "이전에 생성된 번호 : \(oldHitCount)"
                    }
                }
            }
        }
        
        private let countPresentLabel: UILabel = {
            let label = UILabel()
            label.text = "랜덤 번호 생성기"
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            return label
        }()
        
        private let countOldLabel: UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = .systemFont(ofSize: 20)
            label.textColor = .lightGray
            label.textAlignment = .center
            return label
        }()
        
        private lazy var hitBtn: UIButton = {
            let button = UIButton()
            button.setTitle("Hit", for: .normal)
            button.backgroundColor = .systemIndigo
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(tappedHitBtn), for: .touchUpInside)
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()

            style()
            setLayout()
        }

    }

    private extension PropertyViewController {
        
        func style() {
            
            view.backgroundColor = .white
        }
        
        func setLayout() {
            view.addSubviews(countPresentLabel, hitBtn, countOldLabel)
            
            countPresentLabel.snp.makeConstraints {
                $0.bottom.equalTo(hitBtn.snp.top).offset(-20)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(48)
            }
            
            hitBtn.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.height.equalTo(48)
                $0.width.equalTo(96)
            }
            
            countOldLabel.snp.makeConstraints {
                $0.top.equalTo(hitBtn.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(48)
            }
        }
        
        @objc
        func tappedHitBtn() {
            hitBtn.animateButton()
            hitCount = Int.random(in: 1...10)
        }
    }
