//
//  Post.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 4/3/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    init(dictionary:[String : Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
