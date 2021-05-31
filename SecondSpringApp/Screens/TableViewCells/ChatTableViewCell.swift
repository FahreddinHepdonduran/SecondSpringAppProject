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
  @IBOutlet private weak var messageLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private weak var messageTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private weak var nicknameLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private weak var nicknameTrailingConstraint: NSLayoutConstraint!
  
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
    messageTextView.frame.size.width = messageTextView.contentSize.width
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
    if let dateValue = stmp?.dateValue() {
      let dateString2 = String(describing: dateValue)

      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

      let dateObj = dateFormatter.date(from: dateString2)
      dateFormatter.dateFormat = "HH:mm"
      senderNicknameLabel.text = dateFormatter.string(from: dateObj!)
    }
    
    let user = UserInfo(uid: (message["senderID"] as? String) ?? "",
                        name: (message["senderName"] as? String) ?? "",
                        email: (message["senderEmail"] as? String) ?? "",
                        imageUrl: (message["senderImage"] as? String) ?? "")
    
    guard user == currentUser else {
      return
    }
    
    let backgroundColor = UIColor(displayP3Red: 111/255, green: 191/255, blue: 132/255, alpha: 1.0)
    messageTextView.backgroundColor = backgroundColor
    senderNicknameLabel.backgroundColor = backgroundColor
    
    messageLeadingConstraint.constant = 150
    messageTrailingConstraint.constant = 0
    nicknameLeadingConstraint.constant = 150
    nicknameTrailingConstraint.constant = 0
  }
  
}
