//
//  ProfileViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 22.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

final class ProfileViewController: UIViewController, UINavigationControllerDelegate {
  
  @IBOutlet private weak var profilemageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  
  var user: UserInfo!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profilemageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(openPicker)))
    nameLabel.text = user.name
    emailLabel.text = user.email
    downloadImage()
  }
  
  @IBAction func saveButtonDidTap(_ sender: UIButton) {
    uploadImage()
  }
  
}

private extension ProfileViewController {
  
  @objc
  func openPicker() {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  func uploadImage() {
    let image = profilemageView.image
    let imageData = image?.jpegData(compressionQuality: 0.5)
    
    let imageID = UUID()
    
    let imagesRef = Storage.storage().reference().child("images/\(imageID.uuidString).jpg")
    
    imagesRef.putData(imageData!, metadata: nil) { (metadata, error) in
      guard metadata != nil else {
        print(error!)
        return
      }
      print("image upload sucses")
    }
    
    Firestore.firestore().collection("Users").document(user.uid)
      .updateData(["imageUrl" : imageID.uuidString]) { (error) in
        guard error != nil else {
          print("success update imageUrl")
          return
        }
        print(error!.localizedDescription)
    }
  }
  
  func downloadImage() {
    Storage.storage().reference().child("images/\(user.imageUrl).jpg")
      .getData(maxSize: 1*1024*1024) { (data, error) in
        guard error == nil else {
          print(error!.localizedDescription)
          return
        }
        let image = UIImage(data: data!)
        self.profilemageView.image = image
    }
  }
  
}

extension ProfileViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {return}
    profilemageView.image = image
    picker.dismiss(animated: true, completion: nil)
  }
  
}

extension ProfileViewController: StoryboardInstantiable { }
