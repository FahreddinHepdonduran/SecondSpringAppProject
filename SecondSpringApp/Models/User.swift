//
//  User.swift
//  SecondSpringApp
//
//  Created by fahreddin on 17.05.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

struct UserInfo {
  let uid: String
  let name: String
}

extension UserInfo: Equatable {

  static func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
    return lhs.uid == rhs.uid
  }

}

extension UserInfo {
  
  static func userInfo(from data: [String:Any]) -> UserInfo {
    let uid = data["uid"] as! String
    let username = data["username"] as! String
    
    return UserInfo(uid: uid, name: username)
  }
  
}
