//
//  FilterProductCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class FilterProductCell: UICollectionViewCell {
    
    var data : FilterProduct? {
        didSet {
            if let d = data {
                productImageView.image = d.image
                productLabel.text = d.name
            }
        }
    }
    
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
}
