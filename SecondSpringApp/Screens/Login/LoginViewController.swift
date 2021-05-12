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
  
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var loginButton: UIButton!
  
  private let disposeBag = DisposeBag()
  private let throttleInterval = 500
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateRegisterButtonState()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
  }
  
  @IBAction func loginButtonDidTap(_ sender: UIButton) {
    let email = emailTextField.text!
    let password = passwordTextField.text!
    
    FirebaseAuthManager.shared.signInUser(email, password) { [weak self] (result) in
      switch result {
      case .success(_):
        self?.navigateToHome()
      case .failure(_):
        print("login error")
      }
    }
  }
  
}

private extension LoginViewController {
  
  func validatePassword() -> Observable<Bool> {
    let isValidPassword = passwordTextField.rx.text.orEmpty
    .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
    .map({ $0.count >= 6 })
    .share(replay: 1)
    
    return isValidPassword
  }
  
  func validateEmail() -> Observable<Bool> {
    let isValidEmail = emailTextField.rx.text.orEmpty
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .map({ $0.isValidEmail })
      .share(replay: 1)
    
    return isValidEmail
  }
  
  func validateAllFields() -> Observable<Bool> {
    let validEmail = validateEmail()
    let validPassword = validatePassword()
    
    let validAllFields = Observable.combineLatest(validEmail, validPassword) { $0 && $1}
      .share(replay: 1)
    
    return validAllFields
  }
  
  func updateRegisterButtonState() {
    validatePassword()
      .bind(to: loginButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
  func navigateToHome() {
    let homeViewController = HomeViewController.instanceFromStoryboard()
    let navigationController = UINavigationController(rootViewController: homeViewController)
    UIApplication.changeRoot(with: navigationController)
  }
  
}

extension LoginViewController: StoryboardInstantiable { }
