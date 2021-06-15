//
//  ViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashScreenViewController: UIViewController {
  
  var viewControllerFactory: ViewControllerFactory!
  var viewModel = SplashViewModel()
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loginState.asObservable()
      .subscribeOn(MainScheduler.instance)
      .subscribe(onNext: { state in
        switch state {
        case .loggedIn:
          self.perform(#selector(self.changeRootToHome), with: nil, afterDelay: 3)
        case .notLoggedIn:
         self.perform(#selector(self.changeRootToRegister), with: nil, afterDelay: 3)
        }
      })
      .disposed(by: disposeBag)
  }
  
}

private extension SplashScreenViewController {
  
  @objc
  private func changeRootToRegister() {
    let signUpViewController = viewControllerFactory.registerViewController(viewControllerFactory)
    UIApplication.changeRoot(with: signUpViewController)
  }
  
  @objc
  private func changeRootToHome() {
    let homeVC = viewControllerFactory.homeViewController(viewControllerFactory)
    UIApplication.changeRoot(with: homeVC)
  }
  
}

extension SplashScreenViewController: StoryboardInstantiable {}
