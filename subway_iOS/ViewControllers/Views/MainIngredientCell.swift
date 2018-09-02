//
//  MainIngredientCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 2..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class MainIngredientCell: UICollectionViewCell {
    static let cellId = "MainIngredientCell"
    @IBOutlet weak var imageView: UIImageView!
    
    var data : Bread? {
        didSet {
            let resource = URL(string: (data?.image)!)
            imageView.kf.setImage(with: resource)
        }
    }
    
}
