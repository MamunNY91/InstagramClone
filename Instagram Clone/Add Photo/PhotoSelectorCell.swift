//
//  PhotoSelectorCell.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 1/17/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell
{
    let photoImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, paddingTop: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, padingRight: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
