//
//  RegisterViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class RegisterScreenViewController: UIViewController {
  
  @IBOutlet private weak var nicknameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var registerButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
  }
  
  @IBAction func registerButtonDidTapp(_ sender: UIButton) { }
  
}

extension RegisterScreenViewController: StoryboardInstantiable { }
