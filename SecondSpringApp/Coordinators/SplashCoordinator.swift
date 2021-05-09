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
    let viewController = SplashScreenViewController.instanceFromStoryboard()
    router.present(viewController,
                   animated: animated,
                   onDismissed: onDismissed)
  }
  
}
