//
//  SignUpScreenViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

protocol SignUpScreenViewControllerDelegate: class {
  func loginButtonPressed()
  func signUpButtonPressed()
}

final class SignUpScreenViewController: UIViewController {
  
  private weak var delegate: SignUpScreenViewControllerDelegate?
  
  @IBOutlet private weak var signUpButton: UIButton!
  @IBOutlet private weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
  }
  
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    delegate?.loginButtonPressed()
  }
  
  @IBAction func signUpButtonTapped(_ sender: UIButton) {
    delegate?.signUpButtonPressed()
  }
  
}

extension SignUpScreenViewController: StoryboardInstantiable {
  
  class func instance(delegate: SignUpScreenViewControllerDelegate) -> SignUpScreenViewController {
    let viewController = instanceFromStoryboard()
    viewController.delegate = delegate
    return viewController
  }
  
}
