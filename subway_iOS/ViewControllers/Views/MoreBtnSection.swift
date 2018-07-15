//
//  MoreBtnSection.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 15..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class MoreBtnSection: UICollectionReusableView {
        
    @IBOutlet weak var clickArea: UIView!
    @IBOutlet weak var chevron: UIImageView!
    
    override func awakeFromNib() {
        chevron.image = #imageLiteral(resourceName: "chevronDown").withRenderingMode(.alwaysTemplate)
    }
}
