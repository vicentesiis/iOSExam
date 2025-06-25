//
//  Array+Extensions.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import Foundation

extension Array {
  func chunked(into size: Int) -> [[Element]] {
    stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
}
