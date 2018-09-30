//
//  Step3Or7SelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Alamofire

protocol Step3Or7CompleteDelegate {
    func step3Or7Completed(ingredients : [Bread], nextStep: Int)
}

class Step3Or7SelectView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    var list = [IngredientInstance]()
    var completeDelegate : Step3Or7CompleteDelegate?
    var step = 0
    
    let footer = "footer"
    
    class func initializeFromNib() -> Step3Or7SelectView {
        return UINib(nibName: "Step3Or7SelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step3Or7SelectView
    }
    
    override func awakeFromNib() {
        
        collectionView.register(UINib(nibName: "RecipeToppingCell", bundle: nil), forCellWithReuseIdentifier: RecipeToppingCell.cellId)
//        collectionView.register(UIView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footer)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsetsMake(15, 15, 15, 15)
        
        
        
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self , action: #selector(goNextStep), for: .touchUpInside)
    }
    
    func fetchData(){
        
        guard list.isEmpty else {
            return
        }
        
        if step == 3 {
            GetToppings(method: .get, parameters: [:]).requestAPI { [weak self] in
                self?.bindData(response: $0)
            }
        } else if step == 7 {
            GetSauces(method: .get, parameters: [:]).requestAPI { [weak self] in
                self?.bindData(response: $0)
            }
        }
    }
    
    fileprivate func bindData(response: DataResponse<Ingredients>){
        
        guard let statusCode = response.response?.statusCode, statusCode == 200 else {
            print("ERROR GETTING TOPPING OR SAUCE") // show error message
            return
        }
        
        if let value = response.value {
            list.append(contentsOf: value.results.map({
                IngredientInstance(ingredient: $0, clicked: false)
            }))
            collectionView.reloadData()
        }
    }
    
    @objc fileprivate func goNextStep(){
        let selectedToppings = list.filter { $0.clicked }.compactMap{ $0.ingredient }
        completeDelegate?.step3Or7Completed(ingredients: selectedToppings, nextStep: step + 1)
    }
    
}

extension Step3Or7SelectView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeToppingCell.cellId, for: indexPath) as! RecipeToppingCell
        cell.data = list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (frame.width - 60) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        list[indexPath.item].clicked = !list[indexPath.item].clicked
        collectionView.reloadItems(at: [indexPath])
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footer, for: indexPath)
//
////        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 64))
//        footerView.backgroundColor = .yellow
//        return footerView
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
