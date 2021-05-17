//
//  ViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class SplashScreenViewController: UIViewController {
  
  var viewControllerFactory: ViewControllerFactory!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    perform(#selector(changeRootToSignUp), with: nil, afterDelay: 3)
  }
  
  @objc private func changeRootToSignUp() {
    let signUpViewController = viewControllerFactory.SignUpViewController(viewControllerFactory)
    UIApplication.changeRoot(with: signUpViewController)
  }
  
}

extension SplashScreenViewController: StoryboardInstantiable {}
