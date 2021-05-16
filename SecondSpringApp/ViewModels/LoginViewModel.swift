//
//  LoginViewModel.swift
//  SecondSpringApp
//
//  Created by fahreddin on 16.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

final class LoginViewModel {
  
  var emailText: BehaviorSubject<String> = .init(value: "")
  var passwordText: BehaviorSubject<String> = .init(value: "")
  var isFieldsValid: BehaviorSubject<Bool> = .init(value: false)
  var emailPasswordObservable: Observable<(String, String)> = .from([("", "")])
  
  private var disposeBag = DisposeBag()
  
  init() {
    bindEmailPasswordObservable()
    makeValidation()
  }
  
  let loginAction: Action<(String, String), Bool> = Action { credentials in
    let (email, password) = credentials
    
    return .error(error.login)
  }
  
  enum error: Error {
    case login
  }
  
}

private extension LoginViewModel {
  
  private func makeValidation() {
    let isValidEmail = emailText.asObservable()
      .map({ $0.isValidEmail })
    
    let isvalidPassword = passwordText.asObservable()
      .map({ $0.count >= 6 })
    
    let validateAllFields = Observable.combineLatest(isValidEmail,
                                                     isvalidPassword) { $0 && $1 }
    
    validateAllFields
      .bind(to: isFieldsValid)
      .disposed(by: disposeBag)
  }
  
  private func bindEmailPasswordObservable() {
    emailPasswordObservable = Observable.combineLatest(emailText,
    passwordText) { ($0, $1) }
  }
  
}
