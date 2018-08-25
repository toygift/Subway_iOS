//
//  RecipeSandwichCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 26..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeSandwichCell: UITableViewCell {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var sandwichImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    static let cellId = "RecipeSandwichCell"
    
    var data : Sandwich? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func updateUI(){
        guard let d = data else{
            fatalError("data is not set!!")
        }
        sandwichImageView.kf.setImage(with: URL(string: d.imageRight))
        nameLabel.text = d.name
        caloriesLabel.text = "\(d.calories) Kcal"
    }

}
