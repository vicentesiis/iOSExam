//
//  UIImage+Extensions.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit

extension UIImage {
  func resized(to maxSize: CGFloat) -> UIImage? {
    let width = size.width
    let height = size.height
    
    let maxDimension = max(width, height)
    
    if maxDimension <= maxSize {
      return self // no resize needed
    }
    
    let scale = maxSize / maxDimension
    let newSize = CGSize(width: width * scale, height: height * scale)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    draw(in: CGRect(origin: .zero, size: newSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage
  }
}
