//
//  UIApplication+Extensions.swift
//  SecondSpringApp
//
//  Created by fahreddin on 10.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

extension UIApplication {
  
  class func changeRoot(with viewController: UIViewController) {
    let window: UIWindow
    if #available(iOS 13, *) {
      guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let delegate = windowScene.delegate as? SceneDelegate,
        let sceneWindow = delegate.window else { return }
      window = sceneWindow
    } else {
      guard let appWindow = UIApplication.shared.keyWindow else { return }
      window = appWindow
    }
    
    guard let rootViewController = window.rootViewController else {
      return
    }
    DispatchQueue.main.async {
      viewController.view.frame = rootViewController.view.frame
      viewController.view.layoutIfNeeded()
      window.rootViewController = viewController
      // A mask of options indicating how you want to perform the animations.
      let options: UIView.AnimationOptions = .transitionCrossDissolve
      // The duration of the transition animation, measured in seconds.
      let duration: TimeInterval = 0.3
      // Creates a transition animation.
      UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
    }
  }
  
}
