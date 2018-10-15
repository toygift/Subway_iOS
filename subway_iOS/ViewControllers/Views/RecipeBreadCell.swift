//
//  RecipeBreadCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class RecipeBreadCell: UITableViewCell {
    
    static let cellId = "RecipeBreadCell"
    
    @IBOutlet weak var selectedFlagBackground: UIView!
    @IBOutlet weak var breadImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    var data : BreadInstance? {
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
        
        let path = UIBezierPath(roundedRect:selectedFlagBackground.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 15, height:  15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        selectedFlagBackground.layer.mask = maskLayer
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func updateUI(){
        guard let d = data?.bread, let clicked = data?.clicked else {
            fatalError("data is not set - bread")
        }
        
        let placeholder = UIImage(named: "placeholderSandwichRight")
        breadImageView.kf.setImage(with: URL(string: d.image3X), placeholder: placeholder)
       
        nameLabel.text = d.name
        selectedFlagBackground.backgroundColor = clicked ? UIColor.yellowSelected : UIColor.clear
    }
    
}
