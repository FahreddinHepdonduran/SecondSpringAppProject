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
  
  func addDocumentToUsers(_ authResult: AuthDataResult, _ nickname: String,
                   completion: @escaping(Error?) -> Void) {
    firestore.collection("Users").addDocument(data: [
      "uid": authResult.user.uid,
      "username": nickname
    ]) { error in
      if let error = error {
        completion(error)
        return
      }
    }
  }
  
  func addDocumentToRooms(_ room: RoomModel, completion: @escaping(Error?) -> Void) {
    firestore.collection("Rooms").document(room.id.uuidString)
    .setData([
      "id": "\(room.id.uuidString)",
      "name": room.name,
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
  
  func getUserDocument(where id: String, _ completion: @escaping(Result<QueryDocumentSnapshot, Error>) -> Void) {
    firestore.collection("Users").whereField("uid", isEqualTo: id)
      .getDocuments { (querySnapshot, error) in
        guard let querySnapshot = querySnapshot else {
          completion(.failure(error!))
          return
        }
        
        completion(.success(querySnapshot.documents.first!))
    }
  }
  
}
