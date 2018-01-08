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
    
    var user:Users?
    {
        didSet
        {
            setupProfileImage()
            usernameLabel.text = self.user?.userName
        }
    }
    let profileImageView:UIImageView = {
        let iv = UIImageView()
       
        
        return iv
    }()
    let gridButton:UIButton =
    {
            let btn = UIButton(type: .system)
            let img = UIImage(named: "grid")
                btn.setImage(img, for: .normal)
        //btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()
    let listButton:UIButton =
    {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "list")
        btn.setImage(img, for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    let bookmarkButton:UIButton =
    {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "ribbon")
        btn.setImage(img, for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    let usernameLabel:UILabel =
    {
        let label = UILabel()
        //label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let postsLabel:UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14) ]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0 // display second line
        return label
    }()
    let followersLabel:UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14) ]))
        label.attributedText = attributedText
        label.textAlignment = .center
         label.numberOfLines = 0 // display second line
        return label
    }()
    let followingLabel:UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14) ]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0 // display second line
        return label
    }()
    let editButtonProfile:UIButton = {
         let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.borderColor = UIColor.lightGray.cgColor // if we dont add this we wont be able to see border
        btn.layer.borderWidth = 1 // specify the width of the border the defualt is 1
        btn.layer.cornerRadius = 3
        return btn
        
    }()
    let headerTopDividor:UIView = {
        let ht = UIView()
        ht.backgroundColor = UIColor.lightGray
        return ht
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //need to fix this
        addSubview(headerTopDividor)
        headerTopDividor.anchor(top: topAnchor, paddingTop: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, padingRight: 0, bottom: nil, paddingBottom: 0, width: 0, height: 0.5)
        //------------------------------------------------------------
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, paddingTop: 12, left: self.leftAnchor, paddingLeft: 12, right: nil, padingRight: 0, bottom: nil, paddingBottom: 0, width: 80, height: 80)
       
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.layer.masksToBounds = true
        setupBottomToolbar()
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 4, left: self.leftAnchor, paddingLeft: 12, right: nil, padingRight: 0, bottom: gridButton.topAnchor, paddingBottom: 0, width: 0, height: 0)
        setupUserStatsView()
        addSubview(editButtonProfile)
        editButtonProfile.anchor(top: postsLabel.bottomAnchor, paddingTop: 2, left: postsLabel.leftAnchor , paddingLeft: 0, right: followingLabel.rightAnchor, padingRight: 0, bottom: nil, paddingBottom: 0, width: 0, height: 34)
       
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
    fileprivate func setupBottomToolbar()
    {
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        let bottomSeparatorView = UIView()
        bottomSeparatorView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.anchor(top: nil, paddingTop: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, padingRight: 0, bottom: self.bottomAnchor, paddingBottom: 0, width: 0, height: 50)
        addSubview(topDividerView)
        addSubview(bottomSeparatorView)
        topDividerView.anchor(top: stackView.topAnchor, paddingTop: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, padingRight: 0, bottom: nil, paddingBottom: 0, width: 0, height: 0.5)
        bottomSeparatorView.anchor(top: nil, paddingTop: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, padingRight: 0, bottom: stackView.bottomAnchor, paddingBottom: 0, width: 0, height: 0.5)
    }
    fileprivate func setupUserStatsView()
    {
        let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.anchor(top: topAnchor, paddingTop: 12, left: profileImageView.rightAnchor, paddingLeft: 12, right: rightAnchor, padingRight: 12, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        
    }
    
    
    
    
    
    
}
