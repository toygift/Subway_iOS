//
//  FilterButtonCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class BookmarkFilter {
    var id = 0
    var name = ""
    var clicked = false
    
    init(id: Int, name : String, clicked : Bool) {
        self.id = id
        self.name = name
        self.clicked = clicked
    }
}
class Filter {
    var name = ""
    var clicked = false
    
    init(name : String, clicked : Bool) {
        self.name = name
        self.clicked = clicked
    }
    
    func getQueryString() -> String{
        if self.name == "모두" {
            return ""
        } else if self.name == "프레쉬&라이트" {
            return "프레쉬 & 라이트"
        }
        return self.name
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
                label.backgroundColor = UIColor.yellowSelected
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
