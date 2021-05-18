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
    let room = chatRooms[indexPath.row]
    let chatViewController = viewControllerFactory.chatViewController(room)
    navigationController?.pushViewController(chatViewController,
                                             animated: true)
  }
  
}
