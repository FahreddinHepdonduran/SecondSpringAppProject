//
//  CustomTextField.swift
//  SecondSpringApp
//
//  Created by fahreddin on 16.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
  
  let padding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }
  
}
