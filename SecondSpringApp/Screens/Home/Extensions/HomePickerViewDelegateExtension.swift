//
//  HomePickerViewDelegateExtension.swift
//  SecondSpringApp
//
//  Created by fahreddin on 1.06.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {return}
    let imageData = image.jpegData(compressionQuality: 0.2)
    let imageID = UUID().uuidString
    
    let uploadOp = UploadImageOperation(imageData!, imageID: imageID)
    let urlOp = UpdateImageUrl(imageID, self.selectedImageRoomModel!.id.uuidString, "Rooms")
    urlOp.addDependency(uploadOp)
    urlOp.completionBlock = {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    
    queue.addOperation(uploadOp)
    queue.addOperation(urlOp)
    
    
    picker.dismiss(animated: true, completion: nil)
  }
  
}
