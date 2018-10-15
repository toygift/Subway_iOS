//
//  RecipeToppingCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class RecipeToppingCell: UICollectionViewCell {

    static let cellId = "RecipeToppingCell"
    
    @IBOutlet weak var selectedFlagBackground: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var data : IngredientInstance? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedFlagBackground.clipsToBounds = true
        selectedFlagBackground.layer.cornerRadius = 10
    }

    fileprivate func updateUI(){
        guard let d = data?.ingredient, let clicked = data?.clicked else{
            fatalError("data is not set!!")
        }
        
        let placeholder = UIImage(named: "placeholder")
        imageView.kf.setImage(with: URL(string: d.image), placeholder: placeholder)
        nameLabel.text = d.name
        
        nameLabel.textColor = clicked ? UIColor.white : UIColor.grayForDisabledFilter
        selectedFlagBackground.backgroundColor = clicked ? UIColor.yellowSelected : UIColor.clear
        
    }
    
}
