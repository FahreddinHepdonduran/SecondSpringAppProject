//
//  FirebaseFirestoreManager.swift
//  SecondSpringApp
//
//  Created by fahreddin on 12.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseFirestoreManager {
  
  private let firestore = Firestore.firestore()
  
  static let shared = FirebaseFirestoreManager()
  
  private init() { }
  
  func addDocument(_ authResult: AuthDataResult, _ nickname: String,
                   completion: @escaping(Error?) -> Void) {
    firestore.collection("Users").addDocument(data: [
      "uid": authResult.user.uid,
      "nickname": nickname
    ]) { error in
      if let error = error {
        completion(error)
      }
    }
  }
  
  func addRoom(_ room: RoomModel, completion: @escaping(Error?) -> Void) {
    firestore.collection("Rooms").addDocument(data: [
      "id": "\(room.id)",
      "name": room.name,
      "messageHistory": room.messageHistory
    ]) { (error) in
      if let error = error {
        completion(error)
      }
    }
  }
  
  func getChatRooms(_ completion: @escaping([QueryDocumentSnapshot]) -> Void) {
    firestore.collection("Rooms").getDocuments { (snapshot, error) in
      guard let error = error else {
        completion(snapshot!.documents)
        return
      }
      print(error)
    }
  }
  
}
