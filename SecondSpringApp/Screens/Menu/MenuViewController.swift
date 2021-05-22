//
//  MenuTableViewController.swift
//  SecondSpringApp
//
//  Created by fahreddin on 22.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
  func didTapMenuType(_ menuType: MenuType)
}

final class MenuViewController: UITableViewController {
  
  private let menuTypes: [MenuType] = [
    .profile,
    .logOut
  ]
  
  private let rowIcons: [UIImage] = [
    UIImage(named: "person")!,
    UIImage(systemName: "arrow.down.left.circle.fill")!
  ]
  
  weak var delegate: MenuViewControllerDelegate?
  
  override func viewDidLoad() {
  }
  
}

// MARK: - TableViewDelegate
extension MenuViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dismiss(animated: true) {
      self.delegate?.didTapMenuType(self.menuTypes[indexPath.row])
    }
  }
  
}

// MARK: - TableViewDataSoruce
extension MenuViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuTypes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.selectionStyle = .none
    cell.imageView?.image = rowIcons[indexPath.row]
    cell.textLabel?.text = menuTypes[indexPath.row].rawValue
    return cell
  }
  
}

extension MenuViewController: StoryboardInstantiable { }
