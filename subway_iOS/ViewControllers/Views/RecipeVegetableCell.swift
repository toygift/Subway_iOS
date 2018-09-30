//
//  RecipeVegetableCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 25..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    fileprivate func setupViews(){
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    func toggle(on: Bool){
        if on {
            setTitleColor(.white, for: .normal)
            backgroundColor = UIColor.yellowSelected
        } else {
            setTitleColor(.grayForDisabledFilter, for: .normal)
            backgroundColor = UIColor.clear
        }
    }
    
}

class RecipeVegetableCell: UITableViewCell {

    static let cellId = "RecipeVegetableCell"
    
    @IBOutlet weak var contentViewBackground: UIView!
    @IBOutlet weak var shadowBackground: UIView!
    
    @IBOutlet weak var optionIV: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    
    @IBOutlet weak var noButton: ToggleButton!
    @IBOutlet weak var littleButton: ToggleButton!
    @IBOutlet weak var defaultButton: ToggleButton!
    @IBOutlet weak var muchButton: ToggleButton!
    
    var data : VegetableInstance? {
        didSet {
            updateUI()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupViews()
    }
    
    fileprivate func setupViews(){
        contentViewBackground.layer.cornerRadius = 2
        contentViewBackground.clipsToBounds = true
        shadowBackground.layer.cornerRadius = 2
        shadowBackground.clipsToBounds = true
        
    }
    
    fileprivate func toggleButtons(){
        guard let d = data else {
            fatalError("data is not set!!!")
        }
        noButton.toggle(on: d.selectedOption[0])
        littleButton.toggle(on: d.selectedOption[1])
        defaultButton.toggle(on: d.selectedOption[2])
        muchButton.toggle(on: d.selectedOption[3])
    }
    
    fileprivate func updateUI(){
        guard let d = data?.vegetable else {
            fatalError("data is not set!!!")
        }
        
        optionIV.kf.setImage(with: URL(string: d.image))
        optionLabel.text = d.name
        toggleButtons()
    }
    
    
}
