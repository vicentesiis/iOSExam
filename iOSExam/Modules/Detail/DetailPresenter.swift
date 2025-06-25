//
//  DetailPresenter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: AnyObject {
  func viewDidLoad()
  func didFetchQuestions(_ preguntas: [Pregunta])
  func didFailFetchingQuestions(_ error: Error)
  func didTapFooterButton()
}

final class DetailPresenter: DetailPresenterProtocol {
  
  // MARK: - Properties
  weak var view: DetailViewProtocol?
  var interactor: DetailInteractorProtocol
  var router: DetailRouter
  
  private(set) var userInfo: UserInfo
  
  // MARK: - Init
  init(view: DetailViewProtocol, interactor: DetailInteractorProtocol, router: DetailRouter, userInfo: UserInfo) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.userInfo = userInfo
  }
  
  // MARK: - DetailPresenterProtocol
  func viewDidLoad() {
    interactor.fetchQuestions()
  }
  
  func didFetchQuestions(_ preguntas: [Pregunta]) {
    view?.displayQuestions(preguntas)
  }
  
  func didFailFetchingQuestions(_ error: Error) {
    view?.displayError(error.localizedDescription)
  }
  
  func didTapFooterButton() {
    print("didTapFooterButton")
  }
}
