//
//  ViewControllerFactory.swift
//  SecondSpringApp
//
//  Created by fahreddin on 17.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ViewControllerFactory {
  
  func splashViewController(_ viewControllerFactory: ViewControllerFactory) -> SplashScreenViewController {
    let splashViewController = SplashScreenViewController.instanceFromStoryboard()
    splashViewController.viewControllerFactory = viewControllerFactory
    return splashViewController
  }
  
  func SignUpViewController(_ viewControllerFactory: ViewControllerFactory) -> UINavigationController {
    let signUpViewController = SignUpScreenViewController.instanceFromStoryboard()
    signUpViewController.viewControllerFactory = viewControllerFactory
    let navigationController = UINavigationController(rootViewController: signUpViewController)
    navigationController.navigationBar.isHidden = true
    return navigationController
  }
  
  func loginViewController(_ delegate: PopToRootProtocolDelegate,
                           _ viewControllerFactory: ViewControllerFactory) -> LoginViewController {
    let loginViewController = LoginViewController.instanceFromStoryboard()
    loginViewController.delegate = delegate
    loginViewController.viewControllerFactory = viewControllerFactory
    loginViewController.viewModel = LoginViewModel()
    return loginViewController
  }
  
  func registerViewController(_ delegate: PopToRootProtocolDelegate,
                              _ viewControllerFactory: ViewControllerFactory) -> RegisterScreenViewController {
    let registerViewController = RegisterScreenViewController.instanceFromStoryboard()
    registerViewController.delegate = delegate
    registerViewController.viewControllerFactory = viewControllerFactory
    registerViewController.viewModel = RegisterViewModel()
    return registerViewController
  }
  
  func homeViewController(_ viewControllerFactory: ViewControllerFactory) -> UINavigationController {
    let homeViewController = HomeViewController.instanceFromStoryboard()
    homeViewController.viewControllerFactory = viewControllerFactory
    let navigationController = UINavigationController(rootViewController: homeViewController)
    return navigationController
  }
  
}
