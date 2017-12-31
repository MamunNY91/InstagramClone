//
//  UserProfileController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/30/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView?.backgroundColor = .green
       
        fetchUser()
    }
    fileprivate func fetchUser()  {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        Database.database().reference().child("Username").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
           guard   let dictionary  = snapshot.value as? [String:Any] else{return}
             let userName =  dictionary["UserName"] as? String
             self.navigationItem.title =  userName
        }) { (err) in
             print("Failed to fetch user",err)
        }
    }
}
