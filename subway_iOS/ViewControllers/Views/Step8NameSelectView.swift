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
    @IBOutlet weak var resultBackground: UIImageView!
    @IBOutlet weak var resultBackgroundWidth: NSLayoutConstraint!
    
    let centerLabel = UILabel()
    
    class func initializeFromNib() -> Step8NameSelectView{
        return UINib(nibName: "Step8NameSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step8NameSelectView
    }
    
    override func awakeFromNib() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(eventHandler))
        circleView.addGestureRecognizer(tap)
        
        setupLabel()
    }
    
    fileprivate func setupLabel(){
        addSubview(centerLabel)
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        centerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        centerLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        centerLabel.textAlignment = .center
        centerLabel.numberOfLines = 0
        //centerLabel.backgroundColor = .gray
    }
    
    @objc fileprivate func eventHandler(){
        circleView.isHidden = true
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            [weak self] in
            
            var scaleX : CGFloat = 1
            if let width = self?.resultBackground.bounds.width {
                var withinBoundary = true
                let screenWidth = UIScreen.main.bounds.width - 30
                while(withinBoundary) {
                    if(width * scaleX < screenWidth){
                        scaleX += 0.5
                    } else {
                        scaleX -= 0.5
                        withinBoundary = false
                    }
                }
            }
            
            self?.resultBackground.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        }, completion: {
            [weak self] (completed) in
            self?.setLabelText(text: "lorem ipsum")
        })
        
    }
    
    fileprivate func setLabelText(text: String){
        centerLabel.text = text
    }
    
    
}
