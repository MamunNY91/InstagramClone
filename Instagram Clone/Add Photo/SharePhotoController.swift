//
//  SharePhotoController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 1/22/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import UIKit
class SharePhotoController: UIViewController {
    var selectedImage: UIImage?
    {
        didSet
        {
            self.imageView.image = selectedImage
        }
    }
    
    
    let imageView:UIImageView =
    {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let textView:UITextView =
    {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.text = "write description of the image"
        return tv
    }()
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        setupImageAndTextView()
    }
    override var prefersStatusBarHidden: Bool{return true}
    @objc func handleShare()  {
        print("Sharing photo")
    }
    
    fileprivate func setupImageAndTextView()
    {
        let containerView: UIView =
        {
            let cv = UIView()
            cv.backgroundColor = .white
            return cv
        }()
        
        
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(textView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, paddingTop: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, padingRight: 0, bottom: nil, paddingBottom: 0, width: 0, height: 100)
        imageView.anchor(top: containerView.topAnchor, paddingTop: 8, left: containerView.leftAnchor, paddingLeft: 8, right: nil, padingRight: 0, bottom: containerView.bottomAnchor, paddingBottom: 8, width:84 , height: 0)
        textView.anchor(top: containerView.topAnchor, paddingTop: 0, left: imageView.rightAnchor, paddingLeft: 8, right: containerView.rightAnchor, padingRight: 0, bottom: containerView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
    }
}
