//
//  RecipeStepCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 5..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class RecipeData {
    var text : String = ""
    var isInitial : Bool = false
    var isLast : Bool = false
}


class RecipeStepCell: UICollectionViewCell {
    
    static let cellId = "RecipeStepCell"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var data : Step? {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            fatalError("data is not fetched")
        }
        label.text = d.title
        if d.selected {
            label.textColor = UIColor.greenForSelectedOnes
        } else if d.completed {
            label.textColor = UIColor.black
        } else if !d.completed {
            label.textColor = UIColor.grayForShadow
        }
        
        
    }
    
}
