//
//  TableViewDelegateExtension.swift
//  SecondSpringApp
//
//  Created by fahreddin on 17.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let chatViewController = ChatViewController.instanceFromStoryboard()
    chatViewController.room = chatRooms[indexPath.row]
    navigationController?.pushViewController(chatViewController,
                                             animated: true)
  }
  
}
