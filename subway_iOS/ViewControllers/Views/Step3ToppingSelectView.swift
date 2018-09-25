//
//  Step3ToppingSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct ToppingInstance {
    var topping : Bread?
    var clicked = false
}

protocol Step3CompleteDelegate {
    func step3Completed(toppings : [Bread])
}

class Step3ToppingSelectView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    var list = [ToppingInstance]()
    var completeDelegate : Step3CompleteDelegate?
    
    class func initializeFromNib() -> Step3ToppingSelectView {
        return UINib(nibName: "Step3ToppingSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step3ToppingSelectView
    }
    
    override func awakeFromNib() {
        
        collectionView.register(UINib(nibName: "RecipeToppingCell", bundle: nil), forCellWithReuseIdentifier: RecipeToppingCell.cellId)
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
        
        GetToppings(method: .get, parameters: [:]).requestAPI { [weak self] (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                print("ERROR GETTING TOPPINGS") // show error message
                return
            }
            
            if let value = response.value {
                self?.list.append(contentsOf: value.results.map({
                    ToppingInstance(topping: $0, clicked: false)
                }))
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc fileprivate func goNextStep(){
        let selectedToppings = list.filter { $0.clicked }.compactMap{ $0.topping }
        completeDelegate?.step3Completed(toppings: selectedToppings)
    }
    
}

extension Step3ToppingSelectView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
}
