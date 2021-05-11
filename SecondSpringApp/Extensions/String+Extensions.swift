//
//  String+Extensions.swift
//  SecondSpringApp
//
//  Created by fahreddin on 11.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

extension String {
  
  var isValidEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
  
}
