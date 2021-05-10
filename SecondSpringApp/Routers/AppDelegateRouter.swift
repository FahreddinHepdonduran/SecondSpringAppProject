//
//  AppDelegateRouter.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import UIKit

public class AppDelegateRouter: Router {

  public let window: UIWindow

  public init(window: UIWindow) {
    self.window = window
  }

  public func present(_ viewController: UIViewController,
                      animated: Bool,
                      onDismissed: (()->Void)?) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }

  public func dismiss(animated: Bool) {
  }
}
