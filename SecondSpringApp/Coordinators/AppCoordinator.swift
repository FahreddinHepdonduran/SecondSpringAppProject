//
//  SplashCoordinator.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
  
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = SplashScreenViewController.instanceFromStoryboard()
    router.present(viewController,
                   animated: animated,
                   onDismissed: onDismissed)
    
    changeRoot()
  }
  
}

private extension AppCoordinator {
  
  func isLoggedin() -> LoginState {
    return .loggedIn
  }
  
  @objc func changeRoot() {
    let state = self.isLoggedin()
    if state == .loggedIn {
      let signUpViewController = SignUpScreenViewController.instanceFromStoryboard()
      let navigationController = UINavigationController(rootViewController: signUpViewController)
      let navigationRouter = NavigationRouter(navigationController: navigationController)
      let signUpCoordinator = SignUpCoordinator(router: navigationRouter)
      signUpCoordinator.present(animated: false, onDismissed: nil)
    }
  }
  
}
