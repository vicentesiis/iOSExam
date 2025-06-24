//
//  AppRouter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

final class AppRouter {
    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        let mainVC = MainRouter.createModule(appRouter: self)
        navigationController.viewControllers = [mainVC]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
