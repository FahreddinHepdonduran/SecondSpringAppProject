//
//  RegisterViewModel.swift
//  SecondSpringApp
//
//  Created by fahreddin on 17.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

final class RegisterViewModel {
  
  var emailText: BehaviorSubject<String> = .init(value: "")
  var passwordText: BehaviorSubject<String> = .init(value: "")
  var nicknameText: BehaviorSubject<String> = .init(value: "")
  var isFieldsValid: BehaviorSubject<Bool> = .init(value: false)
  var emailPasswordObservable: Observable<(String, String, String)> = .from([("", "", "")])
  
  private let disposeBag = DisposeBag()
  
  init() {
    makeValidation()
    bindEmailPasswordObservable()
  }
  
  let registerAction: Action<(String, String, String), Bool> = Action { credentials in
    let (email, password, username) = credentials
    
    return createUser(username, email, password)
  }
  
}

private extension RegisterViewModel {
  
  class func createUser(_ username: String, _ email: String,
                  _ password: String) -> Observable<Bool> {
    return Observable.create { (observer) -> Disposable in
      FirebaseAuthManager.shared.signUpNewUser(email, password, username) { (result) in
        switch result {
        case .success(_):
          observer.onNext(true)
        case .failure(let error):
          observer.onNext(false)
          observer.onError(error)
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
    passwordText, nicknameText) { ($0, $1, $2) }
  }
  
}
