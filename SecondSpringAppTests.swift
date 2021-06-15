//
//  SecondSpringAppTests.swift
//  SecondSpringAppTests
//
//  Created by fahreddin on 15.06.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import XCTest
import Firebase
import RxSwift
import RxBlocking

@testable import SecondSpringApp

class SecondSpringAppTests: XCTestCase {
  
  var viewModel: LoginViewModel!
  var scheduler: ConcurrentDispatchQueueScheduler!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    viewModel = LoginViewModel()
    scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    scheduler = nil
    try super.tearDownWithError()
  }
  
  func testEmailPasswordValidation() {
    let validateFields = viewModel.isFieldsValid.subscribeOn(scheduler)
    
    viewModel.emailText.onNext("example@gmail.com")
    viewModel.passwordText.onNext("123456")
    
    XCTAssertEqual(try validateFields.toBlocking().first(), true)
  }
  
}
