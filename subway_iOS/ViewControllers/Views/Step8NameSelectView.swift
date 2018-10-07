//
//  Step8NameSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 30..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Step8NameSelectView: UIView {
    
    static let identifier = ""
    
    @IBOutlet weak var circleView: UIView!
    
    class func initializeFromNib() -> Step8NameSelectView{
        return UINib(nibName: "Step8NameSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step8NameSelectView
    }
    
    override func awakeFromNib() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
    }
}
