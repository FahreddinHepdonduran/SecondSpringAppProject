//
//  SplashCoordinator.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import UIKit

final class SplashCoordinator: Coordinator {
  
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = SplashScreenViewController.instantiate(delegate: self)
    router.present(viewController,
                   animated: animated,
                   onDismissed: onDismissed)
  }
  
}

extension SplashCoordinator: SplashScreenViewControllerDelegate {
  
  func changeRootForLoginState(loginState: LoginState) {
    
    if loginState == .loggedIn {
      let viewController = SignUpScreenViewController.instanceFromStoryboard()
      let navigationController = UINavigationController(rootViewController: viewController)
      let navigationRouter = NavigationRouter(navigationController: navigationController)
      let signUpCoordinator = SignUpCoordinator(router: navigationRouter)
      signUpCoordinator.present(animated: true, onDismissed: nil)
    }
    
  }
  
}
