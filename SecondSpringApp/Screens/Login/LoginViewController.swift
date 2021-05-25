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
  
  var viewModel: LoginViewModel!
  var viewControllerFactory: ViewControllerFactory!
  
  private let disposeBag = DisposeBag()
  private let throttleInterval = 250
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textFieldsBindings()
    loginButtonBindings()
    loginActionError()
    loginActionElements()
  }
  
  @IBAction func noAccountButtonDidTap(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
}

private extension LoginViewController {
  
  func loginActionElements() {
    viewModel.loginAction.elements
      .subscribeOn(MainScheduler.instance)
      .filter { $0 }
      .take(1)
      .subscribe(onNext: { [weak self] _ in
        self?.navigateToHome()
      })
      .disposed(by: disposeBag)
  }
  
  func loginActionError() {
    viewModel.loginAction
      .errors
      .subscribe { (error) in
        print("login error")
      }
    .disposed(by: disposeBag)
  }
  
  func textFieldsBindings() {
    emailTextField.rx.text.orEmpty
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.emailText)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text.orEmpty
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.passwordText)
      .disposed(by: disposeBag)
  }
  
  func loginButtonBindings() {
    viewModel.isFieldsValid
      .bind(to: loginButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    viewModel.isFieldsValid
      .subscribeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        self?.loginButton.alpha = $0 ? 1 : 0.5
      })
      .disposed(by: disposeBag)
    
    loginButton.rx.tap
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .withLatestFrom(viewModel.emailPasswordObservable)
      .bind(to: viewModel.loginAction.inputs)
      .disposed(by: disposeBag)
  }
  
  func navigateToHome() {
    let homeViewController = viewControllerFactory.homeViewController(viewControllerFactory)
    UIApplication.changeRoot(with: homeViewController)
  }
  
}

extension LoginViewController: StoryboardInstantiable { }
