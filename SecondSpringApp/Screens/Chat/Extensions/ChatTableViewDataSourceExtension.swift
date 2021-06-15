//
//  UITableViewDataSourceExtension.swift
//  SecondSpringApp
//
//  Created by fahreddin on 18.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

extension ChatViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return room.messageHistory.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
    cell.currentUser = user
    cell.message = room.messageHistory[indexPath.row]
    return cell
  }
  
}
