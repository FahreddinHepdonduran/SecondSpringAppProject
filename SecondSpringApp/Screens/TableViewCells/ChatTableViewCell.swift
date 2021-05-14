//
//  ChatTableViewCell.swift
//  SecondSpringApp
//
//  Created by fahreddin on 14.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet private weak var senderNicknameLabel: UILabel!
  
  var message: [String:String]? {
    didSet {
      guard let message = self.message else { return }
      configure(message: message)
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

private extension ChatTableViewCell {
  
  func configure(message: [String:String]) {
    messageLabel.text = message.values.first
    senderNicknameLabel.text = message.keys.first
  }
  
}
