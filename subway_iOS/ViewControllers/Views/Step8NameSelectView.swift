//
//  Step8NameSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 30..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

protocol Step8CompleteDelegate {
    func step8Completed(name : String)
}

class Step8NameSelectView: UIView {
    
    static let identifier = ""
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var resultBackground: UIImageView!
    @IBOutlet weak var resultBackgroundWidth: NSLayoutConstraint!
    @IBOutlet weak var confirmButton: UIButton!
    
    let centerLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.grayForSandwichName
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let retryButton : UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    var choicesList = [String]()
    var completeDelegate: Step8CompleteDelegate?
    
    fileprivate var sandwichName = ""
    
    class func initializeFromNib() -> Step8NameSelectView{
        return UINib(nibName: "Step8NameSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step8NameSelectView
    }
    
    // MARK: - public methods
    override func awakeFromNib() {
        setupCircleView()
        setupLabel()
        setupRetryButton()
        setupConfirmButton()
    }
    
    func setSandwichName(with name: String){
        sandwichName = name
    }
    
    // MARK: - setting up views
    fileprivate func setupCircleView(){
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(eventHandler))
        circleView.addGestureRecognizer(tap)
    }
    
    fileprivate func setupLabel(){
        addSubview(centerLabel)
        
        centerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        centerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        centerLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    fileprivate func setupRetryButton(){
        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        addSubview(retryButton)
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        retryButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        retryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        retryButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100).isActive = true
    }
    
    fileprivate func setupConfirmButton(){
        confirmButton.layer.cornerRadius = 10
        confirmButton.clipsToBounds = true
        
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
    }
    
    // MARK: - event
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
        })
        
        GetRecipeNameChoicesList(method: .get, parameters:[:]).requestAPI { [weak self] (response) in
            if let value = response.value {
                self?.choicesList.append(contentsOf: value.recipe_name_choices_list)
                let choice = self?.choicesList.removeFirst()
                self?.setLabelText(with: choice ?? "no way!!")
                self?.retryButton.isHidden = false
                self?.setRetryButtonText()
                self?.confirmButton.isHidden = false
            }
        }
        
    }
    
    @objc fileprivate func retry(){
        if choicesList.isEmpty {
            // TODO: - 광고
            print("empty!!!")
        } else {
            setLabelText(with: choicesList.removeFirst())
            setRetryButtonText()
        }
    }
    
    @objc fileprivate func confirm(){
        print("hello world!!")
        if let name = centerLabel.text {
            print("naME", name)
            completeDelegate?.step8Completed(name: name)
        }
    }
    
    
    // MARK: - view binding helpers
    fileprivate func setLabelText(with text: String){
        centerLabel.text = text+" "+sandwichName
    }
    
    fileprivate func setRetryButtonText(){
        let x4 = NSAttributedString(string: "X \(choicesList.count)\n", attributes: [.foregroundColor:UIColor.grayForSandwichName, .font: UIFont.boldSystemFont(ofSize: 20)])
        let retryText = NSAttributedString(string: "다시 뽑기!", attributes: [.foregroundColor:UIColor.grayForSandwichName, .font: UIFont.systemFont(ofSize: 18)])
        
        let attributedString = NSMutableAttributedString(attributedString: x4)
        attributedString.append(retryText)
        retryButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    
    
    
}
