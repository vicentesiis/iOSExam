//
//  MainRouter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

import UIKit

final class MainRouter {
  weak var viewController: UIViewController?
  private weak var appRouter: AppRouter?
  
  init(appRouter: AppRouter) {
    self.appRouter = appRouter
  }
  
  static func createModule(appRouter: AppRouter) -> UIViewController {
    let view = MainViewController()
    let interactor = MainInteractor()
    let router = MainRouter(appRouter: appRouter)
    
    let presenter = MainPresenter(view: view, interactor: interactor, router: router)
    
    view.presenter = presenter
    router.viewController = view
    
    return view
  }
}
