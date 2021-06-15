//
//  HomeMenuViewControllerDelegateExtension.swift
//  SecondSpringApp
//
//  Created by fahreddin on 1.06.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Firebase

extension HomeViewController: MenuViewControllerDelegate {
  
  func didTapMenuType(_ menuType: MenuType) {
    switch menuType {
    case .profile:
      let profileViewController = viewControllerFactory.profileViewController(self.user)
      navigationController?.pushViewController(profileViewController, animated: true)
    case .logOut:
      logOut()
    case .hobies:
      print("hobies")
    }
  }
  
  func logOut() {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else {return}
      do {
        try Auth.auth().signOut()
        self.changeRootSignUp()
      } catch {
        DispatchQueue.main.async {
          print("Error log out")
        }
      }
    }
  }
  
  func changeRootSignUp() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {return}
      
      let signUpController = self.viewControllerFactory
        .registerViewController(self.viewControllerFactory)
      UIApplication.changeRoot(with: signUpController)
    }
  }
  
}
