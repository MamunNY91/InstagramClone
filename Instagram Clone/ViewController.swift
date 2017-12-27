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
        let button = UIButton()
        button.backgroundColor = .red;
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(plusButtonPhoto)
        plusButtonPhoto.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        plusButtonPhoto.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

