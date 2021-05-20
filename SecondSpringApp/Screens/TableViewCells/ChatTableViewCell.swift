//
//  ChatTableViewCell.swift
//  SecondSpringApp
//
//  Created by fahreddin on 14.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import FirebaseFirestore

final class ChatTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var messageTextView: UITextView!
  @IBOutlet private weak var senderNicknameLabel: UILabel!
  
  var currentUser: UserInfo?
  var message: [String : Any]? {
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
  
  func configure(message: [String : Any]) {
    messageTextView.text = message["message"] as? String
    let stmp = message["time"] as? Timestamp
    senderNicknameLabel.text = String(describing: stmp?.dateValue())
    
    let user = UserInfo(uid: (message["senderID"] as? String) ?? "",
                        name: (message["senderName"] as? String) ?? "")
    
    guard user == currentUser else {
      return
    }
    
    messageTextView.backgroundColor = .red
  }
  
}
