//
//  UIView+Extensions.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

extension UIView {
    func pinEdgesToSuperview(withInsets insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { fatalError("No superview for \(self)") }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
