//
//  FilterButtonCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Filter {
    var name = ""
    var clicked = false
    
    init(name : String, clicked : Bool) {
        self.name = name
        self.clicked = clicked
    }
}

class FilterButtonCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var shadow: UIView!
    
    var shadowLayer: CAShapeLayer!
    
    var clicked = false {
        willSet {
            if newValue {
                label.textColor = UIColor.white
                label.backgroundColor = UIColor.yellowForEnabledFilter
                shadow.backgroundColor = UIColor.grayForShadow
            } else {
                label.textColor = UIColor.grayForDisabledFilter
                label.backgroundColor = UIColor.clear
                shadow.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        
        shadow.layer.cornerRadius = 15
    }
    
}
