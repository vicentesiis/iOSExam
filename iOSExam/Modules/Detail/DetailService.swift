//
//  DetailService.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import Foundation

protocol DetailServiceProtocol {
  func fetchData(completion: @escaping (Result<[Pregunta], Error>) -> Void)
}

final class DetailService: DetailServiceProtocol {
  private let canFetch: Bool
  
  init(canFetch: Bool) {
    self.canFetch = canFetch
  }
  
  func fetchData(completion: @escaping (Result<[Pregunta], Error>) -> Void) {
    if canFetch {
      loadFromAPI(completion: completion)
    } else {
      loadLocalJSON(completion: completion)
    }
  }
  
  private func loadLocalJSON(completion: @escaping (Result<[Pregunta], Error>) -> Void) {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
      completion(.failure(NSError(domain: "DetailService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Local JSON not found"])))
      return
    }
    
    do {
      let data = try Data(contentsOf: url)
      let decoded = try decode(data, as: PreguntasResponse.self)
      completion(.success(decoded.data))
    } catch {
      completion(.failure(error))
    }
  }
  
  private func loadFromAPI(completion: @escaping (Result<[Pregunta], Error>) -> Void) {
    guard let url = URL(string: "https://s3.amazonaws.com/dev.reports.files/test.json") else {
      completion(.failure(NSError(domain: "DetailService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        completion(.failure(NSError(domain: "DetailService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
        return
      }
      
      do {
        let decoded = try self.decode(data, as: PreguntasResponse.self)
        completion(.success(decoded.data))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
  
  private func decode<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
    try JSONDecoder().decode(T.self, from: data)
  }
}
