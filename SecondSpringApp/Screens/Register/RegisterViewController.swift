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
  
  weak var delegate: PopToRootProtocolDelegate?
  
  var viewModel: RegisterViewModel!
  var viewControllerFactory: ViewControllerFactory!
  
  private let disposeBag = DisposeBag()
  private let throttleInterval = 250
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nicknameTextField.rx.text.orEmpty
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.nicknameText)
      .disposed(by: disposeBag)
    
    emailTextField.rx.text.orEmpty
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.emailText)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text.orEmpty
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .bind(to: viewModel.passwordText)
      .disposed(by: disposeBag)
    
    viewModel.isFieldsValid
      .bind(to: registerButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    viewModel.isFieldsValid
      .subscribeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        self?.registerButton.alpha = $0 ? 1 : 0.5
      })
      .disposed(by: disposeBag)
    
    registerButton.rx.tap
      .throttle(.milliseconds(throttleInterval), scheduler: MainScheduler.instance)
      .withLatestFrom(viewModel.emailPasswordObservable)
      .bind(to: viewModel.registerAction.inputs)
      .disposed(by: disposeBag)
    
    viewModel.registerAction.elements
      .filter({ $0 })
      .take(1)
      .subscribe(onNext: { [weak self] _ in
        self?.navigateToHome()
      })
    .disposed(by: disposeBag)
    
    viewModel.registerAction.errors
      .subscribe(onError: { error in
        print("register error")
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func haveAnAccountButtonDidTap(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: false)
    delegate?.didPopToRootViewController(from: Self.self)
  }
  
}

private extension RegisterScreenViewController {
  
  func navigateToHome() {
    let homeViewController = viewControllerFactory.homeViewController(viewControllerFactory)
    UIApplication.changeRoot(with: homeViewController)
  }
  
}

extension RegisterScreenViewController: StoryboardInstantiable { }
