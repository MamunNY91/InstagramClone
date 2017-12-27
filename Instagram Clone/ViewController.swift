//
//  ViewController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/27/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let plusButtonPhoto:UIButton =
    {
        let button = UIButton(type:.system)
        let img = UIImage(named: "plus_photo")
        button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let emailTextField:UITextField  =
    {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.borderStyle = .roundedRect
        return tf
    }()
    let userNameField:UITextField  =
    {
        let uf = UITextField()
        uf.placeholder = "Username"
        uf.translatesAutoresizingMaskIntoConstraints = false
        uf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        uf.font = UIFont.systemFont(ofSize: 17)
        uf.borderStyle = .roundedRect
        return uf
    }()
    let passwordField:UITextField  =
    {
        let pf = UITextField()
        pf.placeholder = "Password"
        pf.translatesAutoresizingMaskIntoConstraints = false
        pf.isSecureTextEntry = true
        pf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        pf.font = UIFont.systemFont(ofSize: 17)
        pf.borderStyle = .roundedRect
        return pf
    }()
    
    let signUpButton:UIButton = {
        let btn = UIButton(type:.system)
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(plusButtonPhoto)
        view.addSubview(emailTextField)
        plusButtonPhoto.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusButtonPhoto.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusButtonPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusButtonPhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
       
        setupInputFields()
    }
    fileprivate func setupInputFields()
    {
       
        let stackView = UIStackView(arrangedSubviews: [emailTextField,userNameField,passwordField,signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([ stackView.heightAnchor.constraint(equalToConstant: 200),
                  stackView.topAnchor.constraint(equalTo: plusButtonPhoto.bottomAnchor, constant: 20),
                  stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)])
        
    }
    


}

