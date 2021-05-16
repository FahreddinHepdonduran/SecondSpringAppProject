//
//  StoryboardInstantiable.swift
//  SecondSpringApp
//
//  Created by fahreddin on 9.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: class {
  associatedtype MyType

  static var storyboardFileName: String { get }
  static var storyboardIdentifier: String { get }
  static func instanceFromStoryboard(_ bundle: Bundle?) -> MyType
}

extension StoryboardInstantiable where Self: UIViewController {

  static var storyboardFileName: String {
    return storyboardIdentifier.components(separatedBy: "ViewController").first!
  }

  static var storyboardIdentifier: String {
    return NSStringFromClass(Self.self).components(separatedBy: ".").last!
  }

  static func instanceFromStoryboard(_ bundle: Bundle? = nil) -> Self {
    let fileName = storyboardFileName
    let sb = UIStoryboard(name: fileName, bundle: bundle)
    return sb.instantiateViewController(withIdentifier: self.storyboardIdentifier) as! Self
  }
}
