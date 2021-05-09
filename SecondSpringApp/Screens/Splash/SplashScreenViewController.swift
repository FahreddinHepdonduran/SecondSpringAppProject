//
//  ViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

protocol SplashScreenViewControllerDelegate: class {
  func changeRootForLoginState(loginState: LoginState)
}

final class SplashScreenViewController: UIViewController {
  
  private weak var  delegate: SplashScreenViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    perform(#selector(changeRoot), with: nil, afterDelay: 5.0)
  }
  
  @objc private func changeRoot() {
    delegate?.changeRootForLoginState(loginState: .loggedIn)
  }
  
}

extension SplashScreenViewController: StoryboardInstantiable {
  
  class func instantiate(delegate: SplashScreenViewControllerDelegate) -> SplashScreenViewController {
    let viewController = instanceFromStoryboard()
    viewController.delegate = delegate
    return viewController
  }
  
}
