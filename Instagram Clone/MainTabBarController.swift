//
//  MainTabBarController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/30/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
        if Auth.auth().currentUser == nil
        {
           
            DispatchQueue.main.async {
                 let loginController = LoginController()
                  let navController = UINavigationController(rootViewController: loginController)
                 self.present(navController, animated: true, completion: nil)
            }
            
           
            return // not execute any other code
            
        }
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()        
        let userProfileVC = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileVC)
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
        viewControllers = [navController, UIViewController()]
    }
    
}
