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
  
  @IBOutlet weak var tableView: UITableView!
  
  private var animator = ManuAnimator()
  private var roomListener: ListenerRegistration!
  private var userListener: ListenerRegistration!
  
  var user: UserInfo!
  var viewControllerFactory: ViewControllerFactory!
  var chatRooms = [RoomModel]()
  var selectedImageRoomModel: RoomModel?
  var queue = OperationQueue()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewDelegates()
    configureNavigationController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    listenForRooms()
    listenCurrentUser()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    roomListener.remove()
    userListener.remove()
  }
  
}

private extension HomeViewController {
  
  func configureNavigationController() {
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(rightBarButtonItemAction))
    navigationItem.rightBarButtonItem = rightBarButtonItem
    
    let leftBarButtonItem = UIBarButtonItem(title: "Menu",
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonItemAction))
    navigationItem.leftBarButtonItem = leftBarButtonItem
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
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alertController.addAction(action)
    alertController.addAction(cancel)
    
    present(alertController, animated: true, completion: nil)
  }
  
  @objc
  func leftBarButtonItemAction() {
    let menuViewController = viewControllerFactory.menuViewController(self.animator,
                                                                      self)
    present(menuViewController, animated: true, completion: nil)
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
  
  func listenForRooms() {
    
    roomListener = Firestore.firestore().collection("Rooms")
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
  
  func listenCurrentUser() {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else {return}
      guard let currentUserID = FirebaseAuthManager.shared.getCurrentUser() else { return }
      self.userListener = Firestore.firestore().collection("Users")
        .document(currentUserID.uid).addSnapshotListener({ (doc, error) in
          guard error == nil else {
            DispatchQueue.main.async {
              print(error!.localizedDescription)
            }
            return
          }
          DispatchQueue.main.async {
            print("home screen user fetched")
            self.user = UserInfo.userInfo(from: doc!.data()!)
          }
        })
    }  }
  
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
