//
//  MenuTableViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 22.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class MenuViewController: UITableViewController {
  
  private let rowValues: [String] = [
    "Profile",
    "Sign-Out"
  ]
  
  private let rowIcons: [UIImage] = [
    UIImage(systemName: "Contacts")!,
    UIImage(systemName: "arrow.down.left.circle.fill")!
  ]
  
  override func viewDidLoad() {
  }
  
}

// MARK: - TableViewDelegate
extension MenuViewController { }

// MARK: - TableViewDataSoruce
extension MenuViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rowValues.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.imageView?.image = rowIcons[indexPath.row]
    cell.textLabel?.text = rowValues[indexPath.row]
    return cell
  }
  
}

extension MenuViewController: StoryboardInstantiable { }
