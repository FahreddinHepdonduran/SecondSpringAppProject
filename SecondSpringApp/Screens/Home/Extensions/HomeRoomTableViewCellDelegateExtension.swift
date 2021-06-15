//
//  HomeRoomTableViewCellDelegateExtension.swift
//  SecondSpringApp
//
//  Created by fahreddin on 1.06.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

extension HomeViewController: RoomTableViewCellDelegate {
  
  func didTapRoomImage(model: RoomModel) {
    self.selectedImageRoomModel = model
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
}
