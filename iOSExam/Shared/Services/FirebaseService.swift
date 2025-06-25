//
//  FirebaseService.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import FirebaseFirestore

protocol FirestoreServiceProtocol {
  func saveUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirestoreService: FirestoreServiceProtocol {
  private let db = Firestore.firestore()
  
  func saveUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<Void, Error>) -> Void) {
    var data: [String: Any] = [
      "name": userInfo.name
    ]
    
    if let image = userInfo.selfieImage,
       let resizedImage = image.resized(to: 800), // max 800px width or height
       let imageData = resizedImage.jpegData(compressionQuality: 0.0) {
      
      let base64String = imageData.base64EncodedString()
      
      if base64String.count > 900_000 {
        completion(.failure(NSError(domain: "FirestoreService", code: -1, userInfo: [
          NSLocalizedDescriptionKey: "La imagen es demasiado grande para almacenar en Firestore."
        ])))
        return
      }
      
      data["selfieBase64"] = base64String
    }
    
    db.collection("users").addDocument(data: data) { error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(()))
      }
    }
  }
}
