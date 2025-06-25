//
//  DetailInteractor.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

protocol DetailInteractorProtocol: AnyObject {
  func fetchQuestions()
}

final class DetailInteractor: DetailInteractorProtocol {
  
  // MARK: - Properties
  weak var presenter: DetailPresenterProtocol?
  private let service: DetailServiceProtocol
  
  // MARK: - Init
  init(service: DetailServiceProtocol) {
    self.service = service
  }
  
  // MARK: - DetailInteractorProtocol
  func fetchQuestions() {
    service.fetchData { [weak self] result in
      switch result {
      case .success(let preguntas):
        self?.presenter?.didFetchQuestions(preguntas)
      case .failure(let error):
        self?.presenter?.didFailFetchingQuestions(error)
      }
    }
  }
}
