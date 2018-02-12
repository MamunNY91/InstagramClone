//
//  Extension.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 12/28/17.
//  Copyright © 2017 Samuel Mamun. All rights reserved.
//

import UIKit
extension UIColor
{
    static func rgb(red: CGFloat , green:CGFloat , blue:CGFloat) -> UIColor
   {
     return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
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
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
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
