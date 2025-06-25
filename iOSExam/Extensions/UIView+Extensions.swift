//
//  UIView+Extensions.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

extension UIView {
  
  /// Pins all edges of the view to the specified view or its safeAreaLayoutGuide, with optional insets.
  func pinEdges(
    to view: UIView,
    insets: UIEdgeInsets = .zero,
    useSafeArea: Bool = false
  ) {
    translatesAutoresizingMaskIntoConstraints = false
    
    let topAnchorToUse = useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
    let leadingAnchorToUse = useSafeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor
    let trailingAnchorToUse = useSafeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor
    let bottomAnchorToUse = useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: topAnchorToUse, constant: insets.top),
      leadingAnchor.constraint(equalTo: leadingAnchorToUse, constant: insets.left),
      trailingAnchor.constraint(equalTo: trailingAnchorToUse, constant: -insets.right),
      bottomAnchor.constraint(equalTo: bottomAnchorToUse, constant: -insets.bottom)
    ])
  }
}
