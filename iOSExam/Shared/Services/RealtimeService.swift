//
//  RealtimeService.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import FirebaseDatabase
import UIKit

final class RealtimeService {
  private let dbRef = Database.database(url: "https://ios-test-5e805-default-rtdb.firebaseio.com/").reference()
  
  func observeBackgroundColor(_ onUpdate: @escaping (UIColor) -> Void) {
    dbRef.child("backgroundColor").observe(.value) { snapshot in
      
      if let hexString = snapshot.value as? String {
        if let color = UIColor(hex: hexString) {
          onUpdate(color)
        } else {
          onUpdate(.white)
        }
      } else {
        onUpdate(.white)
      }
    }
  }
}
