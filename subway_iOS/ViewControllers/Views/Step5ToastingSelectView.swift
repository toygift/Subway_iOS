//
//  Step5ToastingSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct ToastingInstance {
    var toasting: Bread?
    var clicked = false
}

protocol Step5CompleteDelegate {
    func step5Completed(toasting: Bread)
}

class Step5ToastingSelectView: UITableView {

    var list = [ToastingInstance]()
    
    var cellHeight: CGFloat = 270
    
    var completeDelegate: Step5CompleteDelegate?
    
    func setupTableView(){
        separatorStyle = .none
    }

}
