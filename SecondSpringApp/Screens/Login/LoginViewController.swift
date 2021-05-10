//
//  LoginViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

  @IBOutlet private weak var nicknameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension LoginViewController: StoryboardInstantiable { }
