//
//  RecipeSingleOptionCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class RecipeSingleOptionCell: UITableViewCell {

    static let cellId = "RecipeSingleOptionCell"
    
    @IBOutlet weak var selectedFlagBackground: UIView!
    @IBOutlet weak var ingredientIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ivWidth: NSLayoutConstraint!
    
    var data: IngredientInstance? {
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
        guard let d = data?.ingredient, let clicked = data?.clicked else {
            fatalError("data is not set - bread")
        }
        
        let placeholder = UIImage(named: "placeholder")
        ingredientIV.kf.setImage(with: URL(string: d.image3X), placeholder: placeholder)
        
        nameLabel.text = getNameLabelText(source: d.name)
        caloriesLabel.text = getDescLabelText(source: d.name)
        selectedFlagBackground.backgroundColor = clicked ? UIColor.yellowSelected : UIColor.clear
    }
    
    fileprivate func getNameLabelText(source: String) -> String{
        switch source {
        case "토스팅":
            return "토스팅 해줘!"
        case "토스팅없음":
            return "토스팅 하지마!"
        case "치즈없음":
            return "치즈 빼!"
        default:
            return source
        }
    }
    
    fileprivate func getDescLabelText(source: String) -> String {
        switch source {
        case "아메리칸 치즈":
            return "40 kcal"
        case "슈레드 치즈":
            return "50 kcal"
        case "치즈없음":
            return ""
        case "토스팅":
            return "따뜻하게 바로 드시기에 좋아요"
        case "토스팅없음":
            return "신선하게 보관 가능해서 두고 먹기에 좋아요"
        default:
            return source
        }
    }
    
}
