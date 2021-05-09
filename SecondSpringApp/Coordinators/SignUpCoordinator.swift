//
//  SignUpCoordinator.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import UIKit

final class SignUpCoordinator: Coordinator {
  
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    guard let navigationRouter = self.router as? NavigationRouter else { return }
    navigationRouter.changeRoot()
  }
  
}
