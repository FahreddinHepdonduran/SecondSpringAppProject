//
//  RoomTableViewCell.swift
//  SecondSpringApp
//
//  Created by fahreddin on 13.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import FirebaseStorage

protocol RoomTableViewCellDelegate: class {
  func didTapRoomImage(model: RoomModel)
}

final class RoomTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var roomImageView: UIImageView!
  @IBOutlet private weak var roomNameLabel: UILabel!
  
  weak var delegate: RoomTableViewCellDelegate?
  
  var model: RoomModel? {
    didSet {
      guard let model = self.model else { return }
      configure(model: model)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    roomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(imageViewRecognizer)))
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    selectionStyle = .none
  }
  
}

private extension RoomTableViewCell {
  
  func configure(model: RoomModel) {
    roomNameLabel.text = model.name
    guard model.imageUrl.count > 1 else {
      return
    }
    downloadImage(model: model)
  }
  
  func downloadImage(model: RoomModel) {
    Storage.storage().reference().child("images/\(model.imageUrl).jpg")
      .getData(maxSize: 1*1024*1024) { [weak self] (data, error) in
        guard error == nil else {
          print(error!.localizedDescription)
          return
        }
        let image = UIImage(data: data!)
        self?.roomImageView.image = image
    }
  }
  
  @objc
  func imageViewRecognizer() {
    guard let room = self.model else {return}
    self.delegate?.didTapRoomImage(model: room)
  }
  
}
