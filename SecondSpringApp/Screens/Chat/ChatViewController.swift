//
//  ChatViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 14.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ChatViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var messageEntryTextView: UITextView!
  @IBOutlet private weak var messageEntryBottomConstraint: NSLayoutConstraint!
  
  var room: RoomModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableviewDelegates()
    configureTableView()
    addNotification()
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

private extension ChatViewController {
  
  @objc
  func keyboarShowNotification(_ notification: Notification) {
    let userInfo = notification.userInfo!
    let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
    let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let moveUp = (notification.name == UIResponder.keyboardWillShowNotification)
    
    messageEntryBottomConstraint.constant = moveUp ? -keyboardHeight : 0
    
    UIView.animate(withDuration: duration) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
  
  func tableviewDelegates() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func configureTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
  }
  
  func addNotification() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboarShowNotification(_:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
  }
  
}

extension ChatViewController: UITableViewDelegate {}

extension ChatViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return room.messageHistory.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
    cell.message = room.messageHistory[indexPath.row]
    return cell
  }
  
}


extension ChatViewController: StoryboardInstantiable { }
