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
    var clicked = false {
        willSet {
            if newValue {
                label.textColor = UIColor.white
                label.backgroundColor = UIColor.yellowForEnabledFilter
            } else {
                label.textColor = UIColor.grayForDisabledFilter
                label.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
    }
}
