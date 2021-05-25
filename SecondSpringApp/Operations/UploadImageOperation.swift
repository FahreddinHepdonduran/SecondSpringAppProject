//
//  UploadImageOperation.swift
//  SecondSpringApp
//
//  Created by fahreddin on 25.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import FirebaseStorage

class UploadImageOperation: AsyncOperation {
  private let imageData: Data
  private let imageID: String
  
  init(_ imageData: Data, imageID: String) {
    self.imageID = imageID
    self.imageData = imageData
  }
  
  override func main() {
    let imagesRef = Storage.storage().reference().child("images/\(self.imageID).jpg")
    
    imagesRef.putData(self.imageData, metadata: nil) { (metadata, error) in
      defer {self.state = .finished}
      guard metadata != nil else {
        print(error!)
        return
      }
      print("image upload sucses")
    }
  }
}
