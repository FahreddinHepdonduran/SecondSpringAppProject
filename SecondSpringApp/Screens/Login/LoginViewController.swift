//
//  LoginViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
  
  @IBOutlet private weak var nicknameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var loginButton: UIButton!
  
  private let disposeBag = DisposeBag()
  private let throttleInterval = 500
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
  }
  
  @IBAction func loginButtonDidTap(_ sender: UIButton) { }
  
}

private extension LoginViewController {
  
  func validatePassword() -> Observable<Bool> {
    let validatePassword = passwordTextField.rx.text.orEmpty
    .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
    .map({ $0.count >= 6 })
    .share(replay: 1)
    
    return validatePassword
  }
  
  func updateRegisterButtonState() {
    validatePassword()
      .bind(to: loginButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
}

extension LoginViewController: StoryboardInstantiable { }
