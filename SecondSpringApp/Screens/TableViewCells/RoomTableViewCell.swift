//
//  RoomTableViewCell.swift
//  SecondSpringApp
//
//  Created by fahreddin on 13.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class RoomTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var roomImageView: UIImageView!
  @IBOutlet private weak var roomNameLabel: UILabel!
  
  var model: RoomModel? {
    didSet {
      guard let model = self.model else { return }
      configure(model: model)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    selectionStyle = .none
    // Configure the view for the selected state
  }
  
}

private extension RoomTableViewCell {
  
  func configure(model: RoomModel) {
    roomNameLabel.text = model.name
  }
  
}
