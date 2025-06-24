//
//  MainPresenter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
  func viewDidLoad()
  var descriptionText: String { get }
}

final class MainPresenter: MainPresenterProtocol {
  weak var view: MainViewProtocol?
  var interactor: MainInteractorProtocol?
  var router: MainRouter?
  
  init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouter) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  func viewDidLoad() {
  }
  
  
  var descriptionText: String {
    return """
      Una gráfica o representación gráfica es un tipo de representación de datos, generalmente numéricos, mediante recursos visuales (líneas, vectores, superficies o símbolos), para que se manifieste visualmente la relación matemática o correlación estadística que guardan entre sí. También es el nombre de un conjunto de puntos que se plasman en coordenadas cartesianas y sirven para analizar el comportamiento de un proceso o un conjunto de elementos o signos que permiten la interpretación de un fenómeno. La representación gráfica permite establecer valores que no se han obtenido experimentalmente sino mediante la interpolación (lectura entre puntos) y la extrapolación (valores fuera del intervalo experimental).
      """
  }
  
}
