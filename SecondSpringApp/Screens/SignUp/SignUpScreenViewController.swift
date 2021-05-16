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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    let loginViewController = LoginViewController.instanceFromStoryboard()
    loginViewController.delegate = self
    navigationController?.pushViewController(loginViewController, animated: true)
  }
  
  @IBAction func signUpButtonTapped(_ sender: UIButton) {
    let registerViewController = RegisterScreenViewController.instanceFromStoryboard()
    registerViewController.delegate = self
    navigationController?.pushViewController(registerViewController, animated: true)
  }
  
}

extension SignUpScreenViewController: PopToRootProtocolDelegate {
  func didPopToRootViewController(from viewController: UIViewController.Type) {
    if viewController == LoginViewController.self {
      let registerViewController = RegisterScreenViewController.instanceFromStoryboard()
      registerViewController.delegate = self
      navigationController?.pushViewController(registerViewController, animated: true)
    } else {
      let loginViewController = LoginViewController.instanceFromStoryboard()
      loginViewController.delegate = self
      navigationController?.pushViewController(loginViewController, animated: true)
    }
  }
}

extension SignUpScreenViewController: StoryboardInstantiable { }
