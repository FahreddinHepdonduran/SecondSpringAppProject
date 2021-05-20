//
//  RoomModel.swift
//  SecondSpringApp
//
//  Created by fahreddin on 13.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

struct RoomModel {
  var id = UUID()
  let name: String
  var messageHistory: [[String : Any]] = [[:]]
}

extension RoomModel {
  static func room(from data: [String:Any]) -> RoomModel {
    let id = data["id"] as! String
    let name = data["name"] as! String
    let messageHistory = data["messageHistory"] as! [[String : Any]]
 
    return RoomModel(id: UUID(uuidString: id)!,
                     name: name, messageHistory: messageHistory)
  }
}
