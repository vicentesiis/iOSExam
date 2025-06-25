//
//  DetailPresenter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
  func viewDidLoad()
  func didFetchQuestions(_ preguntas: [Pregunta])
  func didFailFetchingQuestions(_ error: Error)
}

final class DetailPresenter: DetailPresenterProtocol {
  
  // MARK: - Properties
  weak var view: DetailViewProtocol?
  var interactor: DetailInteractorProtocol
  var router: DetailRouter
  
  // MARK: - Init
  init(view: DetailViewProtocol, interactor: DetailInteractorProtocol, router: DetailRouter) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  // MARK: - DetailPresenterProtocol
  func viewDidLoad() {
    interactor.fetchQuestions()
  }
  
  func didFetchQuestions(_ preguntas: [Pregunta]) {
    DispatchQueue.main.async {
      self.view?.displayQuestions(preguntas)
    }
  }
  
  func didFailFetchingQuestions(_ error: Error) {
    DispatchQueue.main.async {
      self.view?.displayError(error.localizedDescription)
    }
  }
}
