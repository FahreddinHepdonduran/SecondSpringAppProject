//
//  MenuAnimator.swift
//  SecondSpringApp
//
//  Created by fahreddin on 22.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ManuAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  private var presenting = true
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let container = transitionContext.containerView
    let toVC = transitionContext.viewController(forKey: .to)!
    let fromVC = transitionContext.viewController(forKey: .from)!
      
    let finalWidth = toVC.view.frame.width * 0.8
    let finalHeight = UIScreen.main.bounds.height
    
    if presenting {
      container.addSubview(toVC.view)
      toVC.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
    }
    
    let transform = {
      toVC.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
    }
    
    let identity = {
      fromVC.view.transform = .identity
    }
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext),
                   animations: {
                    self.presenting ? transform() : identity()
    },
                   completion: { _ in
                    transitionContext.completeTransition(true)
    })
  }
  
}

extension ManuAnimator: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = true
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    self.presenting = false
    return self
  }
  
}
