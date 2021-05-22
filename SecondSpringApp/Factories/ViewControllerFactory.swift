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
  
  func loginViewController(_ viewControllerFactory: ViewControllerFactory) -> LoginViewController {
    let loginViewController = LoginViewController.instanceFromStoryboard()
    loginViewController.viewControllerFactory = viewControllerFactory
    loginViewController.viewModel = LoginViewModel()
    return loginViewController
  }
  
  func registerViewController(_ viewControllerFactory: ViewControllerFactory) -> UINavigationController {
    let registerViewController = RegisterScreenViewController.instanceFromStoryboard()
    registerViewController.viewControllerFactory = viewControllerFactory
    registerViewController.viewModel = RegisterViewModel()
    let navigationController = UINavigationController(rootViewController: registerViewController)
    navigationController.navigationBar.isHidden = true
    return navigationController
  }
  
  func homeViewController(_ viewControllerFactory: ViewControllerFactory) -> UINavigationController {
    let homeViewController = HomeViewController.instanceFromStoryboard()
    homeViewController.viewControllerFactory = viewControllerFactory
    let navigationController = UINavigationController(rootViewController: homeViewController)
    return navigationController
  }
  
  func chatViewController(_ room: RoomModel, _ user: UserInfo) -> ChatViewController {
    let chatViewController = ChatViewController.instanceFromStoryboard()
    chatViewController.room = room
    chatViewController.user = user
    return chatViewController
  }
  
  func menuViewController(_ transitionDelegate: UIViewControllerTransitioningDelegate,
                          _ delegate: MenuViewControllerDelegate) -> MenuViewController {
    let menuViewController = MenuViewController.instanceFromStoryboard()
    menuViewController.transitioningDelegate = transitionDelegate
    menuViewController.delegate = delegate
    return menuViewController
  }
  
  func profileViewController() -> ProfileViewController {
    let profileViewController = ProfileViewController.instanceFromStoryboard()
    return profileViewController
  }
  
}
