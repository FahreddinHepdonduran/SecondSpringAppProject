//
//  ProfileViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 22.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, UINavigationControllerDelegate {
  
  @IBOutlet private weak var profilemageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  
  var user: UserInfo? {
    didSet {
      guard let user = user else { return }
      nameLabel.text = user.name
      emailLabel.text = user.email
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profilemageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(openPicker)))
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
  
}

extension ProfileViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {return}
    profilemageView.image = image
    picker.dismiss(animated: true, completion: nil)
  }
  
}

extension ProfileViewController: StoryboardInstantiable { }
