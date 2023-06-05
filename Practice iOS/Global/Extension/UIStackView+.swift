//
//  UIStackView+.swift
//  Practice iOS
//
//  Created by 김다예 on 2023/06/05.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
