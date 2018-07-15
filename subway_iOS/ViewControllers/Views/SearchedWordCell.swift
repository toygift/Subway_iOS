//
//  SearchedWordCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class SearchedWordCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var data : String? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 15
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            fatalError("the data is not set")
        }
        
        textLabel.text = d
    }
}
