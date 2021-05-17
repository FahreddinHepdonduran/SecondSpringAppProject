//
//  FirebaseManager.swift
//  SecondSpringApp
//
//  Created by fahreddin on 11.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseAuthManager {
  
  private let auth = Auth.auth()
  private let firestore = FirebaseFirestoreManager.shared
  
  static let shared = FirebaseAuthManager()
  
  private init() { }
  
  func signUpNewUser(_ email: String, _ password: String, _ nickname: String,
                     completion: @escaping(Result<User, Error>) -> Void) {
    auth.createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
      guard let authResult = authResult, error == nil else {
        guard let error = error else { return }
        completion(.failure(error))
        return
      }
      
      completion(.success(authResult.user))
      
      self?.firestore.addDocument(authResult, nickname) { (error) in
        guard let error = error else { return }
        completion(.failure(error))
      }
    }
  }
  
  func signInUser(_ email: String, _ password: String,
                  _ completion: @escaping(Result<AuthDataResult, Error>) -> Void) {
    auth.signIn(withEmail: email, password: password) { (authResult, error) in
      guard let authResult = authResult else {
        completion(.failure(error!))
        return
      }
      
      completion(.success(authResult))
    }
  }
  
}
