//
//  ChatViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 14.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import FirebaseFirestore

final class ChatViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var messageEntryTextView: UITextView!
  @IBOutlet private weak var messageEntryBottomConstraint: NSLayoutConstraint!
  @IBOutlet private weak var messageEntryHeightConstraint: NSLayoutConstraint!
  @IBOutlet private weak var sendButton: UIButton!
  @IBOutlet private weak var sendButtonBottomConstraint: NSLayoutConstraint!
  
  var room: RoomModel!
  
  private var userName: String {
    return UserDefaults.standard.value(forKey: "nickname") as! String
  }
  
  private var docRef: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableviewDelegates()
    configureTableView()
    addNotification()
    
    Firestore.firestore().collection("Rooms")
      .whereField("id", isEqualTo: room.id.uuidString)
      .getDocuments { (querySnapsoht, error) in
        if let error = error {
          print(error)
        } else {
          self.docRef = querySnapsoht?.documents.first?.documentID
          self.addListener(self.docRef!)
        }
    }
    
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @IBAction func sendButtonDidTap(_ sender: UIButton) {
    let message = [userName:messageEntryTextView.text!]
    Firestore.firestore().collection("Rooms")
    .document(docRef!).updateData([
      "messageHistory": FieldValue.arrayUnion([message])
    ])
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
    sendButtonBottomConstraint.constant = moveUp ? -keyboardHeight : 0
    
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
  
  func addListener(_ docRef: String) {
    Firestore.firestore().collection("Rooms")
      .document(docRef).addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
          }
        self.room.messageHistory = document.data()!["messageHistory"] as! [[String:String]]
        self.tableView.reloadData()
    }
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
