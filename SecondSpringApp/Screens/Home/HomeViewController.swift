//
//  HomeViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 11.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit
import Firebase

final class HomeViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var user: UserInfo!
  var chatRooms = [RoomModel]()
  
  var viewControllerFactory: ViewControllerFactory!
  var listener: ListenerRegistration!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewDelegates()
    configureNavigationController()
    setUserInfo()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    listenForRooms()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    listener.remove()
  }
  
}

private extension HomeViewController {
  
  func configureNavigationController() {
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(rightBarButtonItemAction))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  @objc
  func rightBarButtonItemAction() {
    let alertController = UIAlertController(title: "Add Room",
                                            message: nil,
                                            preferredStyle: .alert)
    alertController.addTextField { (textfield) in
      textfield.placeholder = "Type Room Name"
    }
    
    let action = UIAlertAction(title: "Ok", style: .default) { [weak self] (_) in
      guard let textfield = alertController.textFields?.first else { return }
      let room = RoomModel(name: textfield.text!)
      self?.addRoomToFirebase(room)
    }
    
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func addRoomToFirebase(_ room: RoomModel) {
    FirebaseFirestoreManager.shared.addDocumentToRooms(room) { (error) in
      guard let error = error else {
        print("room succedded")
        return
      }
      
      print(error)
    }
  }
  
  func setUserInfo() {
    FirebaseAuthManager.shared.getCurrentUserInfo { [weak self] (result) in
      switch result {
      case .success(let userInfo):
        self?.user = userInfo
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func listenForRooms() {
    listener = Firestore.firestore().collection("Rooms")
      .addSnapshotListener { (querySnapShot, error) in
        guard let querySnapShot = querySnapShot else {
          print(error!)
          return
        }
        
        self.chatRooms.removeAll(keepingCapacity: false)
        for document in querySnapShot.documents {
          let room = RoomModel.room(from: document.data())
          self.chatRooms.append(room)
        }
        self.reloadTableView()
    }
  }
  
  func tableViewDelegates() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func reloadTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
}

extension HomeViewController: StoryboardInstantiable { }
