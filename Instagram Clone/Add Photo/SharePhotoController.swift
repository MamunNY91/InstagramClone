//
//  SharePhotoController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 1/22/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase
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
        tv.placeholder = "Add description of your image"
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
        guard let caption = textView.text , caption.count > 0 else {return}
        // if we add guard statement if the statement becomes false next line does not execute
        guard let image = selectedImage else {return}
        guard let uploadImage = UIImageJPEGRepresentation(image, 0.5) else {return}
        navigationItem.rightBarButtonItem?.isEnabled = false
        let fileName = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(fileName).putData(uploadImage, metadata: nil) { (metadata, err) in
            if let err = err
            {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to post image ", err)
                return
            }
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else {return}
            print("successfully uploaded image" ,  imageUrl)
            self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
        }
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
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String)
    {
        guard  let postImage = selectedImage else {return}
        guard let caption = textView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
       let userPostRef =  Database.database().reference().child("posts").child(uid)
       let ref =  userPostRef.childByAutoId()
        let values = ["imageUrl" : imageUrl, "caption":caption, "imageWidth":postImage.size.width,
                      "imageHeight":postImage.size.height,"creationDate": Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err
            {
                 self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
