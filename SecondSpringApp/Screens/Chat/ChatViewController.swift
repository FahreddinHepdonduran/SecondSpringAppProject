//
//  ChatViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 14.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import FirebaseFirestore
import RxSwift
import RxCocoa

final class ChatViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var messageEntryTextView: UITextView!
  @IBOutlet private weak var sendButton: UIButton!
  @IBOutlet private weak var messageEntryBottomConstraint: NSLayoutConstraint!
  @IBOutlet private weak var messageEntryHeightConstraint: NSLayoutConstraint!
  @IBOutlet private weak var sendButtonBottomConstraint: NSLayoutConstraint!
  
  private let disposeBag = DisposeBag()
  private var listener: ListenerRegistration!
  private var docRef: DocumentReference {
    return Firestore.firestore()
    .collection("Rooms")
      .document(room.id.uuidString)
    
  }
  
  var room: RoomModel!
  var user: UserInfo!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    addNotification()
    sendMessage()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addListener()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    listener.remove()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

private extension ChatViewController {
  
  func addNotification() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboarShowNotification(_:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardHideNotification),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  @objc
  func keyboarShowNotification(_ notification: Notification) {
    let userInfo = notification.userInfo!
    let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
    
    messageEntryBottomConstraint.constant = -(keyboardHeight - 34)
    sendButtonBottomConstraint.constant = -(keyboardHeight - 34)
    
    UIView.animate(withDuration: 0.25) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
  
  @objc
  func keyboardHideNotification() {
    messageEntryBottomConstraint.constant = 0
    sendButtonBottomConstraint.constant = 0
    
    UIView.animate(withDuration: 0.25) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
  
  func addListener() {
    listener = docRef.addSnapshotListener { (documentSnapshot, error) in
      guard let documentSnapshot = documentSnapshot else {
        print(error!)
        return
      }
      
      self.room.messageHistory = documentSnapshot.data()!["messageHistory"] as! [[String : Any]]
      self.tableView.reloadData()
    }
  }
  
  func sendMessage() {
    sendButton.rx.tap
      .withLatestFrom(messageEntryTextView.rx.text.orEmpty)
      .subscribe(onNext: { (text) in
        let message: [String : Any] = [
          "senderID" : self.user.uid,
          "senderName" : self.user.name,
          "message" : text,
          "time" : Timestamp(date: Date())
        ]
        self.docRef.updateData([
          "messageHistory" : FieldValue.arrayUnion([message])
        ])
      })
    .disposed(by: disposeBag)
  }
  
  func configureTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
  }
  
}

extension ChatViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    let maxHeight = (textView.font?.lineHeight ?? 0.0)*6
    
    guard messageEntryHeightConstraint.constant < maxHeight else { return }
    messageEntryHeightConstraint.constant = messageEntryTextView.contentSize.height
  }
}

extension ChatViewController: StoryboardInstantiable { }
