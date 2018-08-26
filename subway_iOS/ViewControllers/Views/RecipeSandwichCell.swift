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
    @IBOutlet weak var selectedFlagBackground: UIView!
    
    static let cellId = "RecipeSandwichCell"
    
    var data : Sandwich? {
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
        selectedFlagBackground.backgroundColor = UIColor.yellowSelected
        
        infoButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
    }
    
    @objc fileprivate func showDetail(){
        guard let d = data else{
            fatalError("data is not set!!")
        }
        
        let vc = UIStoryboard(name: "Tab2", bundle: nil).instantiateViewController(withIdentifier: NutrientInfoPopupViewController.identified) as! NutrientInfoPopupViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.data = d
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
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
