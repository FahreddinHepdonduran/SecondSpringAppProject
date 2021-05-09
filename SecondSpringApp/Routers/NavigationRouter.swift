//
//  NavigationRouter.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import UIKit

// 1
public class NavigationRouter: NSObject {

  // 2
  private let navigationController: UINavigationController
  private let routerRootController: UIViewController?
  private var onDismissForViewController:
    [UIViewController: (() -> Void)] = [:]

  // 3
  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.routerRootController =
      navigationController.viewControllers.first
    super.init()
    navigationController.delegate = self
  }
  
  func changeRoot() {
    UIApplication.changeRoot(with: navigationController)
  }
}

// MARK: - Router
extension NavigationRouter: Router {

  // 1
  public func present(_ viewController: UIViewController,
                      animated: Bool,
                      onDismissed: (() -> Void)?) {
    onDismissForViewController[viewController] = onDismissed
    navigationController.pushViewController(viewController,
                                            animated: animated)
  }

  // 2
  public func dismiss(animated: Bool) {
    guard let routerRootController = routerRootController else {
      navigationController.popToRootViewController(
        animated: animated)
      return
    }
    performOnDismissed(for: routerRootController)
    navigationController.popToViewController(
      routerRootController,
      animated: animated)
  }

  // 3
  private func performOnDismissed(for
    viewController: UIViewController) {

    guard let onDismiss =
      onDismissForViewController[viewController] else {
      return
    }
    onDismiss()
    onDismissForViewController[viewController] = nil
  }
}

// MARK: - UINavigationControllerDelegate
extension NavigationRouter: UINavigationControllerDelegate {

  public func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool) {

    guard let dismissedViewController =
      navigationController.transitionCoordinator?
        .viewController(forKey: .from),
      !navigationController.viewControllers
        .contains(dismissedViewController) else {
      return
    }
    performOnDismissed(for: dismissedViewController)
  }
}
