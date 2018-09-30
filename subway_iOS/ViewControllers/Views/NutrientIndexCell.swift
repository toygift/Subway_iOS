//
//  NutrientIndexCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 2..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct NutrientIndex {
    var title : String = ""
    var figure : Int = 0
}

class NutrientIndexCell: UICollectionViewCell {
    static let cellId = "NutrientIndexCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var figureLabel: UILabel!
    
    var data : NutrientIndex? {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            fatalError("data not set")
        }
        
        titleLabel.text = d.title
        figureLabel.text = "\(d.figure)"
    }
}
