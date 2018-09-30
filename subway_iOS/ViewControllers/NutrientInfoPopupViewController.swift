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
    
    static let identifier = "NutrientInfoPopupViewController"
    let titles = ["중량(g)", "열량(kcal)", "당류(g)", "단백질(g)", "포화지방(g)", "나트륨(mg)"]
    
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
        nutrientCV.delegate = self
        nutrientCV.dataSource = self
    }
    

    @objc fileprivate func exit(){
        dismiss(animated: true, completion: nil)
    }

}



extension NutrientInfoPopupViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let d = data else {
            fatalError("data not set")
        }
        
        if collectionView == mainIngredientCV {
            return d.mainIngredient.count
        } else if collectionView == nutrientCV {
            return 6 // TODO: - think how we can validate this number
        }
        return 0
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
        } else if collectionView == nutrientCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NutrientIndexCell.cellId, for: indexPath) as! NutrientIndexCell
            cell.data = getNutrientIndex(i: indexPath.item)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainIngredientCV {
            return CGSize(width: 70, height: 50)
        } else if collectionView == nutrientCV{
            let width = titles[indexPath.item].count * 3 + 45
            return CGSize(width: width, height: 50)
        }
        return CGSize(width: 50, height: 50) // not reachable
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == nutrientCV {
            return 0
        } else {
            return 5
        }
    }
    
    fileprivate func getNutrientIndex(i : Int) -> NutrientIndex{
        var title = ""
        var figure = 0
        
        guard let d = data, i >= 0, i < 6 else {
            fatalError("data not set or i out of bounds")
        }
        
        title = titles[i]
        switch i {
            case 0: figure = d.servingSize; break
            case 1: figure = d.calories; break
            case 2: figure = d.sugars; break
            case 3: figure = d.protein; break
            case 4: figure = d.saturatedFat; break
            case 5: figure = d.sodium; break
            default: figure = 0; break
        }
        return NutrientIndex(title: title, figure: figure)
    }
    
}
