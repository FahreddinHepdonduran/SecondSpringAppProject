//
//  RoomModel.swift
//  SecondSpringApp
//
//  Created by fahreddin on 13.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

struct RoomModel: Codable {
  var id = UUID()
  let name: String
  var messageHistory: [[String:String]] = [
    ["hasan":"merhaba grup"],
    ["hasan":"merhaba grup"],
    ["hasan":"merhaba grup"]
  ]
  
  enum CodingKeys: CodingKey {
    case id
    case name
    case messageHistory
  }
  
}
