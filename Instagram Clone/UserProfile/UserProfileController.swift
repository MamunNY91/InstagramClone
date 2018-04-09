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
    let cellId = "cellId"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        fetchUser()
        collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
       
        setupLogoutButton()
        fetchPosts()
    }
    var posts = [Post]()
    fileprivate func fetchPosts ()
    {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String : Any] else{return}
            dictionaries.forEach({ (key, value) in
                //print("key \(key) , value: \(value)")
                guard let dictionary = value as? [String : Any] else {return}
                
                let post = Post(dictionary: dictionary)
                //print(post.imageUrl)
                self.posts.append(post)
                self.collectionView?.reloadData()
                
            })
        }) { (err) in
            print("Failed to fetch posts" , err)
        }
        
    }
    fileprivate func setupLogoutButton()
    {
        let img = UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(handleLogout))
    }
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
           do
            {
               try Auth.auth().signOut()
                let loginControoler = LoginController()
                let navController = UINavigationController(rootViewController: loginControoler)
                self.present(navController, animated: true, completion: nil)
            } catch let signUpErr
            {
               print("Failed to sign out",signUpErr)
            }
            
            
        }))  // log out
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) // cancel alert action
        
        present(alertController, animated: true, completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        header.user = self.user
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellId, for: indexPath)
            as! UserProfilePhotoCell
        cell.post = posts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (view.frame.width-2)/3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
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
