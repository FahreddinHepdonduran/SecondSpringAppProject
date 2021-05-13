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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewDelegates()
    configureNavigationController()
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
    
  }
  
}

extension HomeViewController: UITableViewDelegate { }

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell") as! RoomTableViewCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
}

extension HomeViewController: StoryboardInstantiable { }
