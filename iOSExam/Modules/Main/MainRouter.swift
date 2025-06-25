//
//  MainRouter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    func navigateToDetail()
}

final class MainRouter: MainRouterProtocol {
  // MARK: - Properties
  weak var viewController: UIViewController?
  
  // MARK: - Create Module
  static func createModule() -> UIViewController {
    let view = MainViewController()
    let interactor = MainInteractor()
    let router = MainRouter()
    
    let presenter = MainPresenter(view: view, interactor: interactor, router: router)
    
    view.presenter = presenter
    router.viewController = view
    
    return view
  }
  
  // MARK: - MainRouterProtocol
  func navigateToDetail() {
    guard let navigation = viewController?.navigationController else { return }
    let detailVC = DetailRouter.createModule()
    navigation.pushViewController(detailVC, animated: true)
  }
}
