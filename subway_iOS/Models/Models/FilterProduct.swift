//
//  FilterProduct.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

struct FilterProduct {
    var image : UIImage?
    var name : String?
    var clicked : Bool = false
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
        self.clicked = false
    }
    
}
