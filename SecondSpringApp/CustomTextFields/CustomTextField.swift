//
//  CustomTextField.swift
//  SecondSpringApp
//
//  Created by fahreddin on 16.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
  
  @IBInspectable var leftImage: UIImage? = nil
  @IBInspectable var leftPadding: CGFloat = 0
  @IBInspectable var gapPadding: CGFloat = 0
  
  private var textPadding: UIEdgeInsets {
    let p: CGFloat = leftPadding + gapPadding + (leftView?.frame.width ?? 0)
    return UIEdgeInsets(top: 0, left: p, bottom: 0, right: 5)
  }
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: textPadding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: textPadding)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: textPadding)
  }
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var r = super.leftViewRect(forBounds: bounds)
    r.origin.x += leftPadding
    r.origin.y = 10
    r.size.height = 30
    r.size.width = 30
    return r
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
  
  private func setup() {
    if let image = leftImage {
      if leftView != nil { return } // critical!
      
      let im = UIImageView()
      im.contentMode = .scaleAspectFit
      im.image = image
      
      leftViewMode = UITextField.ViewMode.always
      leftView = im
      
    } else {
      leftViewMode = UITextField.ViewMode.never
      leftView = nil
    }
  }
}
