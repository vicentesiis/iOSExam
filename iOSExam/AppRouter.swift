//
//  AppRouter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit
import Firebase

final class AppRouter {
  
  // MARK: - Properties
  private let window: UIWindow
  private let navigationController: UINavigationController
  private let realtimeService = RealtimeService()
  
  // MARK: - Init
  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
  }
  
  func start() {
    let mainVC = MainRouter.createModule()
    navigationController.viewControllers = [mainVC]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    observeRealtimeBackground()
  }
  
  private func observeRealtimeBackground() {
    realtimeService.observeBackgroundColor { [weak self] color in
      guard let self = self else { return }
      
      UIView.animate(withDuration: 0.3) {
        self.window.backgroundColor = color
        self.navigationController.view.backgroundColor = color
        self.navigationController.navigationBar.barTintColor = color
        self.navigationController.navigationBar.backgroundColor = color
      }
    }
  }
}
