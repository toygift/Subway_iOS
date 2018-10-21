//
//  SearchedWordCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class SearchedWordCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    var data : String? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            fatalError("the data is not set")
        }
        label.text = d
    }
}
