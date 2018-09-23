//
//  RecipeCheeseCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class RecipeCheeseCell: UITableViewCell {

    static let cellId = "RecipeCheeseCell"
    
    @IBOutlet weak var selectedFlagBackground: UIView!
    @IBOutlet weak var cheeseIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    var data: CheeseInstance? {
        didSet {
            updateUI()
        }
    }
    
    var clicked = false {
        willSet {
            if newValue {
                selectedFlagBackground.backgroundColor = UIColor.yellowSelected
            } else {
                selectedFlagBackground.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    fileprivate func setupViews(){
        selectionStyle = .none
        
        selectedFlagBackground.clipsToBounds = true
        selectedFlagBackground.layer.cornerRadius = 10
    }
    
    fileprivate func updateUI(){
        guard let d = data?.cheese, let clicked = data?.clicked else {
            fatalError("data is not set - bread")
        }
        
        cheeseIV.kf.setImage(with: URL(string: d.image3X))
        
        nameLabel.text = d.name
        selectedFlagBackground.backgroundColor = clicked ? UIColor.yellowSelected : UIColor.clear
    }
    
    
}
