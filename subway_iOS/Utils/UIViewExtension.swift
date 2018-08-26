//
//  UIViewExtension.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 26..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

extension UIView {
    //Get Parent View Controller from any view
    func parentViewController() -> UIViewController {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return (responder as? UIViewController)!
    }
}
