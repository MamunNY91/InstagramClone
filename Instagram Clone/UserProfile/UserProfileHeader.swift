//
//  UserProfileHeader.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/31/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase
class UserProfileHeader: UICollectionViewCell {
    let profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        
        return iv
    }()
    var user:Users?
    {
        didSet
        {
           setupProfileImage()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, paddingTop: 12, left: leftAnchor, paddingLeft: 12, right: nil, padingRight: 0, bottom: nil, paddingBottom: 0, width: 80, height: 80)
       
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.layer.masksToBounds = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupProfileImage()
    {
        guard let pImageUrl = user?.profileImageUrl else {return}
        guard let url = URL(string:pImageUrl) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error and contruct the image using data
            guard let data = data else {return}
            let image = UIImage(data: data)
            //get on main thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            if let err = err
            {
                print("Failed to fetch profile image url",err)
                return
            }
            }.resume()
       
    }
}
