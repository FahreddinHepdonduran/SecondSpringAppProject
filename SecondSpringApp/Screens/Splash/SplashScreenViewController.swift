//
//  ViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class SplashScreenViewController: UIViewController {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    perform(#selector(changeRootToSignUp), with: nil, afterDelay: 3)
  }
  
  @objc private func changeRootToSignUp() {
    let signUpViewController = SignUpScreenViewController.instanceFromStoryboard()
    let navigationController = UINavigationController(rootViewController: signUpViewController)
    navigationController.navigationBar.isTranslucent = true
    UIApplication.changeRoot(with: navigationController)
  }
  
}

extension SplashScreenViewController: StoryboardInstantiable {}
