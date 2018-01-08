//
//  ViewController.swift
//  Instagram Clone
//
//  Created by Samuel Mamun on 12/27/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
import Firebase
class SignUpController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let plusButtonPhoto:UIButton =
    {
        let button = UIButton(type:.system)
        let img = UIImage(named: "plus_photo")
        button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    @objc func handlePlusPhoto()
    {
       let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if   let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
           plusButtonPhoto.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
           
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            plusButtonPhoto.setImage(originalImage, for: .normal)
        }
        plusButtonPhoto.layer.cornerRadius = plusButtonPhoto.frame.width/2
        plusButtonPhoto.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
        
    }
    let emailTextField:UITextField  =
    {
        let tf = UITextField()
        tf.placeholder = "Email"
       
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    let userNameField:UITextField  =
    {
        let uf = UITextField()
        uf.placeholder = "Username"
       
        uf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        uf.font = UIFont.systemFont(ofSize: 17)
        uf.borderStyle = .roundedRect
        uf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return uf
    }()
    let passwordField:UITextField  =
    {
        let pf = UITextField()
        pf.placeholder = "Password - Must be 6 characters"
       
        pf.isSecureTextEntry = true
        pf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        pf.font = UIFont.systemFont(ofSize: 17)
        pf.borderStyle = .roundedRect
        pf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return pf
    }()
    
    let signUpButton:UIButton = {
        let btn = UIButton(type:.system)
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    @objc func handleSignUp()  {
        
        guard  let email  = emailTextField.text , email.count > 0  else {return}
        guard let password = passwordField.text ,password.count > 0 else{return}
         guard let username = userNameField.text, username.count > 0  else{return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user : User?, error:Error?) in
            if let err = error
            {
                print("Failed to create user",err)
                return
            }
            
            
            print("Successfully created user",user?.uid ?? "")
            // for saving profile image
            guard  let image = self.plusButtonPhoto.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else{return}
            let fileName = NSUUID().uuidString
            
            Storage.storage().reference().child("profile_images").child(fileName).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if let err = err
                {
                    print("Failed to create store profile image", err)
                    return
                }
               
                 print("Successfully saved image into Storage")
                 guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                // for saving username
                guard let uid = user?.uid else{return}
                let userNameValues = ["UserName":username,"profileImageUrl": profileImageUrl]
                let values = [uid:userNameValues]
                Database.database().reference().child("Username").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err  = err
                    {
                        print("Failed to save data into DB ",err)
                        return
                    }
                    print("Successfully saved data into DB")
                })
            })
            
            
            
        }
    }
    @objc func handleTextInputChange()
    {
        let isEmailValid = emailTextField.text?.count ?? 0 > 0
         let isUserNameValid  = userNameField.text?.count ?? 0 > 0
        let isPasswordValid = passwordField.text?.count ?? 6 >= 6
        
        if isEmailValid && isUserNameValid && isPasswordValid
        {
            signUpButton.isEnabled = true
             signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }
        else
        {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        view.addSubview(plusButtonPhoto)
        view.addSubview(emailTextField)
        plusButtonPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusButtonPhoto.anchor(top: view.topAnchor, paddingTop: 40, left: nil, paddingLeft: 0, right: nil, padingRight: 0, bottom: nil, paddingBottom: 0, width: 140, height: 140)
        setupInputFields()
    }
    fileprivate func setupInputFields()
    {
       
        let stackView = UIStackView(arrangedSubviews: [emailTextField,userNameField,passwordField,signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusButtonPhoto.bottomAnchor, paddingTop: 20, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, padingRight: 40, bottom: nil, paddingBottom: 0, width: 0, height: 200)
        
    }
    

}
extension UIView
{
    func anchor(top:NSLayoutYAxisAnchor?,paddingTop:CGFloat,
                left:NSLayoutXAxisAnchor?,paddingLeft:CGFloat,right:NSLayoutXAxisAnchor?,padingRight:CGFloat,
                bottom:NSLayoutYAxisAnchor?,paddingBottom:CGFloat, width:CGFloat,height:CGFloat ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top
        {
            self.topAnchor.constraint(equalTo:top, constant: paddingTop).isActive = true
        }
        if let left = left
        {
            self.leftAnchor.constraint(equalTo:left, constant: paddingLeft).isActive = true
        }
        if let right = right
        {
            self.rightAnchor.constraint(equalTo:right, constant: -padingRight).isActive = true
        }
        if let bottom = bottom
        {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if width != 0
        {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


