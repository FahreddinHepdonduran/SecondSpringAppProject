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
    return signInUser(email, password)
  }
  
}

private extension LoginViewModel {
  
  class func signInUser(_ email: String, _ password: String) -> Observable<Bool> {
    return Observable.create { (observer) -> Disposable in
      DispatchQueue.global().async {
        FirebaseAuthManager.shared.signInUser(email, password) { (result) in
          switch result {
          case .success(_):
            observer.onNext(true)
          case .failure(let error):
            observer.onNext(false)
            observer.onError(error)
          }
        }
      }
      
      return Disposables.create()
    }
  }
  
  func makeValidation() {
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
  
  func bindEmailPasswordObservable() {
    emailPasswordObservable = Observable.combineLatest(emailText,
    passwordText) { ($0, $1) }
  }
  
}
