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
  
  private var user: User? {
    guard let currentUser = Auth.auth().currentUser else {
      return nil
    }
    
    return currentUser
  }
  
  private var chatRooms = [RoomModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewDelegates()
    configureNavigationController()
    fetchRooms()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
}

private extension HomeViewController {
  
  func tableViewDelegates() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
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
      self?.chatRooms.append(room)
      self?.reloadTableView()
      self?.addRoomsToFirebase(room)
    }
    
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func addRoomsToFirebase(_ room: RoomModel) {
    FirebaseFirestoreManager.shared.addRoom(room) { (error) in
      guard let error = error else {
        print("room succedded")
        return
      }
      
      print(error)
    }
  }
  
  func fetchRooms() {
    FirebaseFirestoreManager.shared.getChatRooms { [weak self] (documents) in
      for document in documents {
        let docid = document["id"] as! String
        let idfromstr = UUID(uuidString: docid)
        let room = RoomModel(id: idfromstr!,
                             name: document["name"] as! String,
                             messageHistory: document["messageHistory"] as! [[String:String]])
        self?.chatRooms.append(room)
      }
      
      self?.reloadTableView()
    }
  }
  
  func reloadTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let chatViewController = ChatViewController.instanceFromStoryboard()
    chatViewController.room = chatRooms[indexPath.row]
    navigationController?.pushViewController(chatViewController,
                                             animated: true)
  }
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatRooms.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell") as! RoomTableViewCell
    let roomModel = chatRooms[indexPath.row]
    cell.model = roomModel
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
}

extension HomeViewController: StoryboardInstantiable { }
