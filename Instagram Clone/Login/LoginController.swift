//
//  LoginController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 1/4/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import UIKit
class LoginController: UIViewController {
    let logoContainerView:UIView =
    {
        let lc = UIView()
        lc.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        let img = UIImage(named: "Instagram_logo_white")
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleToFill
        lc.addSubview(imgView)
        imgView.anchor(top: nil, paddingTop: 0, left: nil, paddingLeft: 0, right: nil, padingRight: 0, bottom: nil, paddingBottom: 0, width: 200, height: 50)
        imgView.centerXAnchor.constraint(equalTo: lc.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: lc.centerYAnchor).isActive = true
        
        return lc
    }()
    let emailTextField:UITextField =
    {
        let et = UITextField()
        et.placeholder = "Email"
        et.backgroundColor = UIColor(white: 0, alpha: 0.03)
        et.font = UIFont.systemFont(ofSize: 14)
        et.borderStyle = .roundedRect
        et.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return et
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
    
    
    @objc func handleTextInputChange()
    {
        let isEmailValid = emailTextField.text?.count ?? 0 > 0
        let isPasswordValid = passwordField.text?.count ?? 6 >= 6
        
        if isEmailValid  && isPasswordValid
        {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }
        else
        {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    let dontHaveAccountButton:UIButton = {
        let btn = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
        attributedText.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.addTarget(self, action: #selector(handleDontHaveAccountButton), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func handleDontHaveAccountButton()
    {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    let loginButton:UIButton =
    {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    @objc func handleLogin()
       {
          print(123)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, paddingTop: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, padingRight: 0, bottom: nil, paddingBottom: 0, width: 0, height: 150)
        view.backgroundColor = .white
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, paddingTop: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, padingRight: 0, bottom: view.bottomAnchor, paddingBottom: 0, width: 0, height: 50)
        setInput()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
          return.lightContent
    }
    func setInput()
    {
      let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordField,loginButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, paddingTop: 40, left: view.leftAnchor , paddingLeft: 40, right: view.rightAnchor, padingRight: 40, bottom: nil, paddingBottom: 0, width: 0, height: 140)
        
    }
    
    
    
}
