//
//  RegisterViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RegisterScreenViewController: UIViewController {
  
  @IBOutlet private weak var nicknameTextField: UITextField!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var registerButton: UIButton!
  
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
  
  @IBAction func registerButtonDidTapp(_ sender: UIButton) {
    let homeViewController = HomeViewController.instanceFromStoryboard()
    let navigationController = UINavigationController(rootViewController: homeViewController)
    UIApplication.changeRoot(with: navigationController)
  }
  
}

private extension RegisterScreenViewController {
  
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
    validateAllFields()
      .bind(to: registerButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
}

extension RegisterScreenViewController: StoryboardInstantiable { }
