//
//  SplashViewModel.swift
//  SecondSpringApp
//
//  Created by fahreddin on 14.06.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import RxSwift
import RxCocoa

class SplashViewModel {
  
  var loginState: Observable<LoginState> {
    return Observable.create { (observer) -> Disposable in
      guard FirebaseAuthManager.shared.getCurrentUser() != nil else {
        observer.onNext(.notLoggedIn)
        return Disposables.create()
      }
      
      observer.onNext(.loggedIn)
      return Disposables.create()
    }
  }
  
}
