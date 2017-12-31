//
//  MainTabBarController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/30/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
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
