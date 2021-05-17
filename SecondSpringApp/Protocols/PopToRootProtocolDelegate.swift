//
//  PopToRootProtocol.swift
//  SecondSpringApp
//
//  Created by fahreddin on 16.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

protocol PopToRootProtocolDelegate: class {
  func didPopToRootViewController(from viewController: UIViewController.Type)
}
