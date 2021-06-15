//
//  AsyncOperation.swift
//  SecondSpringApp
//
//  Created by fahreddin on 25.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
  // Create state management
  enum State: String {
    case ready, executing, finished

    fileprivate var keyPath: String {
      return "is\(rawValue.capitalized)"
    }
  }

  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }

  // Override properties
  override var isReady: Bool {
    return super.isReady && state == .ready
  }

  override var isExecuting: Bool {
    return state == .executing
  }

  override var isFinished: Bool {
    return state == .finished
  }

  override var isAsynchronous: Bool {
    return true
  }

  // Override start
  override func start() {
    main()
    state = .executing
  }
}
