//
// Created by khpark on 2018. 8. 19..
// Copyright (c) 2018 TeamSubway. All rights reserved.
//

import Foundation

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width)+1
    }
}