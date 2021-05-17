//
//  SignUpScreenViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class SignUpScreenViewController: UIViewController {
  
  @IBOutlet private weak var signUpButton: UIButton!
  @IBOutlet private weak var loginButton: UIButton!
  
  var viewControllerFactory: ViewControllerFactory!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    presentLogin()
  }
  
  @IBAction func signUpButtonTapped(_ sender: UIButton) {
    presentRegister()
  }
  
  private func presentLogin() {
    let loginViewController = viewControllerFactory.loginViewController(self,
                                                                        viewControllerFactory)
    navigationController?.pushViewController(loginViewController, animated: true)
  }
  
  private func presentRegister() {
    let registerViewController = viewControllerFactory.registerViewController(self,
                                                                              viewControllerFactory)
    navigationController?.pushViewController(registerViewController, animated: true)
  }
  
}

extension SignUpScreenViewController: PopToRootProtocolDelegate {
  func didPopToRootViewController(from viewController: UIViewController.Type) {
    if viewController == LoginViewController.self {
      presentRegister()
    } else {
      presentLogin()
    }
  }
}

extension SignUpScreenViewController: StoryboardInstantiable { }
