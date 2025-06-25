//
//  MainPresenter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
  var descriptionText: String { get }
  var hasSelfie: Bool { get }
  var currentSelfieImage: UIImage? { get }
  func didTapGoToDetail()
  func updateName(_ name: String)
  func updateSelfieImage(_ image: UIImage)
}

final class MainPresenter: MainPresenterProtocol {
  
  // MARK: - Properties
  weak var view: MainViewProtocol?
  var interactor: MainInteractorProtocol?
  var router: MainRouterProtocol?
  
  private var name: String = ""
  private var selfieImage: UIImage?
  
  // MARK: - Init
  init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  var descriptionText: String {
    return """
    Una gráfica o representación gráfica es un tipo de representación de datos, generalmente numéricos, mediante recursos visuales (líneas, vectores, superficies o símbolos), para que se manifieste visualmente la relación matemática o correlación estadística que guardan entre sí. También es el nombre de un conjunto de puntos que se plasman en coordenadas cartesianas y sirven para analizar el comportamiento de un proceso o un conjunto de elementos o signos que permiten la interpretación de un fenómeno. La representación gráfica permite establecer valores que no se han obtenido experimentalmente sino mediante la interpolación (lectura entre puntos) y la extrapolación (valores fuera del intervalo experimental).
    """
  }
  
  // MARK: - MainPresenterProtocol
  var hasSelfie: Bool { selfieImage != nil }
  
  var currentSelfieImage: UIImage? { selfieImage }
  
  func updateName(_ name: String) { self.name = name }
  
  func updateSelfieImage(_ image: UIImage) { self.selfieImage = image }
  
  func didTapGoToDetail() {
    let userInfo = UserInfo(name: name, selfieImage: selfieImage)
    router?.navigateToDetail(with: userInfo)
  }
}
