//
//  CountryOfOriginCell.swift
//  subway_iOS
//
//  Created by khpark on 28/10/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit

class CountryOfOriginCell: UITableViewCell {

    static let cellId = "CountryOfOriginCell"
    
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var data : CountryOfOrigin? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            fatalError("data not set")
        }
        
        iconIV.image = UIImage(named: d.imageName)
        nameLabel.text = d.name
        contentLabel.text = d.content
    }
    
}
