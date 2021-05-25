//
//  UpdateImageUrl.swift
//  SecondSpringApp
//
//  Created by fahreddin on 25.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import FirebaseFirestore

class UpdateImageUrl: AsyncOperation {
  private let imageID: String
  private let documentID: String
  
  init(_ imageID: String, _ documentID: String) {
    self.imageID = imageID
    self.documentID = documentID
  }
  
  override func main() {
    Firestore.firestore().collection("Users").document(documentID)
      .updateData(["imageUrl" : imageID]) { (error) in
        defer {self.state = .finished}
        guard error != nil else {
          print("success update imageUrl")
          return
        }
        print(error!.localizedDescription)
    }
  }
}
