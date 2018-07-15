//
//  FilterProductCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class FilterProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var yellowBackground: UIView!
    @IBOutlet weak var shadow: UIView!
    
    var data : FilterProduct? {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            fatalError("no data set")
        }
        
        productImageView.image = d.image
        productLabel.text = d.name
        
        if d.clicked {
            yellowBackground.backgroundColor = UIColor.yellowForEnabledFilter
            shadow.backgroundColor = UIColor.grayForShadow
            productLabel.textColor = UIColor.white
            
        } else {
            yellowBackground.backgroundColor = UIColor.white
            shadow.backgroundColor = UIColor.clear
            productLabel.textColor = UIColor.grayForDisabledFilter
        }
    }
    
    override func awakeFromNib() {
        yellowBackground.layer.cornerRadius = 10
        yellowBackground.layer.masksToBounds = true
        shadow.layer.cornerRadius = 10
        shadow.layer.masksToBounds = true
    }
    
    
}
