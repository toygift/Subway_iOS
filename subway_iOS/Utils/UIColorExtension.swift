//
//  UIColorExtension.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(netHex : Int){
        self.init(red: CGFloat((netHex>>16) & 0xff), green: CGFloat((netHex>>8) & 0xff), blue: CGFloat(netHex & 0xff), alpha: 1.0)
    }
    
    static var grayForDisabledFilter : UIColor {
        return UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 1.0)
    }
    
    static var grayForShadow : UIColor {
        return UIColor(red: 113/255, green: 113/255, blue: 113/255, alpha: 0.3)
    }
    
    static var yellowSelected : UIColor {
        return UIColor(red: 255/255, green: 205/255, blue: 0, alpha: 1.0)
    }
    
    static var greenForSelectedOnes : UIColor {
        return UIColor(red: 0/255, green: 153/255, blue: 69/255, alpha: 1.0)
    }
    
    static var grayForSandwichName : UIColor {
        return UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
    }
}
