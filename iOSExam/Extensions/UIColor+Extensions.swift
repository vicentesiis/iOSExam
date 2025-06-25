//
//  UIColor+Extensions.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit

extension UIColor {
  convenience init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0
    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

    if hexSanitized.count == 6 {
      let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      let b = CGFloat(rgb & 0x0000FF) / 255.0
      self.init(red: r, green: g, blue: b, alpha: 1.0)
      return
    }

    return nil
  }
}
