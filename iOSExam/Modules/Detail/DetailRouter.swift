//
//  DetailRouter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit

final class DetailRouter {
  
  // MARK: - Properties
  weak var viewController: UIViewController?
  
  // MARK: - Create Module
  static func createModule(userInfo: UserInfo) -> DetailViewController {
    let view = DetailViewController()
    let service = DetailService(canFetch: false)
    let interactor = DetailInteractor(service: service)
    let router = DetailRouter()
    
    let presenter = DetailPresenter(
      view: view,
      interactor: interactor,
      router: router,
      userInfo: userInfo
    )
    
    view.presenter = presenter
    interactor.presenter = presenter
    router.viewController = view
    
    return view
  }
}
