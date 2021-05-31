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
  
  func addDocumentToUsers(_ authResult: AuthDataResult, _ email: String, _ nickname: String,
                   completion: @escaping(Error?) -> Void) {
    firestore.collection("Users").document(authResult.user.uid)
      .setData([
        "uid" : authResult.user.uid,
        "username" : nickname,
        "email" : email,
        "imageUrl" : ""
      ])
  }
  
  func addDocumentToRooms(_ room: RoomModel, completion: @escaping(Error?) -> Void) {
    firestore.collection("Rooms").document(room.id.uuidString)
    .setData([
      "id": "\(room.id.uuidString)",
      "name": room.name,
      "imageUrl" : room.imageUrl,
      "messageHistory": room.messageHistory
    ]){ (error) in
      if let error = error {
        completion(error)
      }
    }
  }
  
  func getDocumentsFromRooms(_ completion: @escaping([QueryDocumentSnapshot]) -> Void) {
    firestore.collection("Rooms").getDocuments { (snapshot, error) in
      guard let error = error else {
        completion(snapshot!.documents)
        return
      }
      print(error)
    }
  }
  
  func getUserDocument(id: String, _ completion: @escaping(Result<DocumentSnapshot, Error>) -> Void) {
    firestore.collection("Users").document(id).getDocument { (documentSnapShot, error) in
      guard let error = error else {
        completion(.success(documentSnapShot!))
        return
      }
      
      completion(.failure(error))
    }
  }
  
}
