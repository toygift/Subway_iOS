//
//  NutrientInfoPopupViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 26..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class NutrientInfoPopupViewController: UIViewController {

    @IBOutlet var backdrop: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var mainIngredientCV: UICollectionView!
    @IBOutlet weak var nutrientCV: UICollectionView!
    
    static let identified = "NutrientInfoPopupViewController"
    
    var data : Sandwich?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupEvents()
        updateUI()
    }
    
    fileprivate func setupViews(){
        containerView.layer.cornerRadius = 10
        
    }
    
    
    fileprivate func setupEvents(){
        let backdropTap = UITapGestureRecognizer(target: self, action: #selector(exit))
        backdrop.addGestureRecognizer(backdropTap)
        
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
    }
    
    fileprivate func updateUI(){
        guard let d = data else {
            print("data not set")
            return
        }
        
        titleLabel.text = d.name
        
        mainIngredientCV.delegate = self
        mainIngredientCV.dataSource = self
        
        
    }
    

    @objc fileprivate func exit(){
        dismiss(animated: true, completion: nil)
    }

}



extension NutrientInfoPopupViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let d = data else {
            fatalError("data not set")
        }
        
        if collectionView == mainIngredientCV {
            return d.mainIngredient.count
        }
        
        return 0 // TODO: - add logic for this!!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let d = data else {
            fatalError("data not set")
        }
        
        if collectionView == mainIngredientCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainIngredientCell.cellId, for: indexPath)
             as! MainIngredientCell
            cell.data = d.mainIngredient[indexPath.item]
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
}
