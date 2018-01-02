//
//  UserProfileController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/30/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController,UICollectionViewDelegateFlowLayout
{
    var user :Users?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        fetchUser()
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        header.user = self.user
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    fileprivate func fetchUser()  {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        Database.database().reference().child("Username").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
           guard   let dictionary  = snapshot.value as? [String:Any] else{return}
            self.user = Users(dictionary: dictionary)
        
             self.navigationItem.title =  self.user?.userName
             self.collectionView?.reloadData()
        }) { (err) in
             print("Failed to fetch user",err)
        }
    }
}
struct Users {
    let userName:String
    let profileImageUrl:String
    init(dictionary:[String:Any]) {
        userName = dictionary["UserName"] as? String ?? ""
        profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}
