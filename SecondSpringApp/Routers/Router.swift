//
//  Router.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

public protocol Router: class {
  func present(_ viewController: UIViewController, animated: Bool)
  func present(_ viewController: UIViewController,
               animated: Bool,
               onDismissed: (()->Void)?)
  func dismiss(animated: Bool)
}

extension Router {
  public func present(_ viewController: UIViewController,
                      animated: Bool) {
    present(viewController, animated: animated, onDismissed: nil)
  }
}
