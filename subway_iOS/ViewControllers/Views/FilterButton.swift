//
//  FilterButton.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class FilterButton: UIButton {
    
    var clicked : Bool = false {
        willSet {
            if newValue {
                setTitleColor(UIColor.white, for: .normal)
                setBackgroundImage(#imageLiteral(resourceName: "boxSelectedArrangment"), for: .normal)
            } else {
                setTitleColor(UIColor.grayForDisabledFilter, for: .normal)
                setBackgroundImage(nil, for: .normal)
            }
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup() {
        addTarget(self, action: #selector(toggleView), for: .touchUpInside)
    }
    
    deinit {
        removeTarget(self, action: #selector(toggleView), for: .touchUpInside)
    }
    
    @objc func toggleView(){
        clicked = !clicked
    }
    
}
