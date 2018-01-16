//
//  MainTabBarController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/30/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2
        {
            let photoSelector = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
            let navPhotoSelector = UINavigationController(rootViewController: photoSelector)
            self.present(navPhotoSelector, animated: true, completion: nil)
           return false
        }
             return true
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        if Auth.auth().currentUser == nil
        {
           //show if not logged in
            DispatchQueue.main.async {
                 let loginController = LoginController()
                  let navController = UINavigationController(rootViewController: loginController)
                 self.present(navController, animated: true, completion: nil)
            }
            return // not execute any other code
        }
        setupViewControllers()
       
    }
    func setupViewControllers()
    {
        //home controller
        let homeNavController = templateNavController(imgUnselected: "home_unselected", imgSelected: "home_selected", rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        //like controller
        let likeNavController = templateNavController(imgUnselected: "like_unselected", imgSelected: "like_selected")
        // search controller
        let searchNavController = templateNavController(imgUnselected: "search_unselected", imgSelected: "search_selected")
        // plus controller
        let plusNavController = templateNavController(imgUnselected: "plus_unselected", imgSelected: "plus_unselected")
        //user profile controller
        let userProfileNavController = templateNavController(imgUnselected: "profile_unselected", imgSelected: "profile_selected", rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        tabBar.tintColor = .black
        viewControllers = [homeNavController,searchNavController,plusNavController,likeNavController,userProfileNavController]
        //set tab bar item to the center
        guard let items = tabBar.items else {
            return
        }
        for item in items
        {
              item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        }
    }
    fileprivate func templateNavController(imgUnselected:String, imgSelected:String,rootViewController:UIViewController = UIViewController() ) -> UINavigationController
    {
        let viewController = rootViewController
        let viewNavController = UINavigationController(rootViewController: viewController)
        viewNavController.tabBarItem.image = UIImage(named: imgUnselected)
        viewNavController.tabBarItem.selectedImage = UIImage(named: imgSelected)
        return viewNavController
    }
}
