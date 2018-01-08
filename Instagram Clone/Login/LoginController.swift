//
//  LoginController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 1/4/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import UIKit
class LoginController: UIViewController {
    let signUpButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Don't have an account? Sign Up", for: .normal)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()
    @objc func handleSignUp()
    {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, paddingTop: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, padingRight: 0, bottom: view.bottomAnchor, paddingBottom: 0, width: 0, height: 50)
    }
}
