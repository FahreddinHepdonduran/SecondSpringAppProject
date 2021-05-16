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
  
  weak var delegate: PopToRootProtocolDelegate?
  
  private let disposeBag = DisposeBag()
  private let viewModel = LoginViewModel()
  private let throttleInterval = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emailTextField.rx.text.orEmpty
      .throttle(.seconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.emailText)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text.orEmpty
      .throttle(.seconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.passwordText)
      .disposed(by: disposeBag)
    
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
      .withLatestFrom(viewModel.emailPasswordObservable)
      .bind(to: viewModel.loginAction.inputs)
      .disposed(by: disposeBag)
    
    viewModel.loginAction
      .errors
      .subscribe { (error) in
        print("login error")
      }
    .disposed(by: disposeBag)
  }
  
  @IBAction func noAccountButtonDidTap(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: false)
    delegate?.didPopToRootViewController(from: Self.self)
  }
}

private extension LoginViewController {
  
  func navigateToHome() {
    let homeViewController = HomeViewController.instanceFromStoryboard()
    let navigationController = UINavigationController(rootViewController: homeViewController)
    UIApplication.changeRoot(with: navigationController)
  }
  
}

extension LoginViewController: StoryboardInstantiable { }
