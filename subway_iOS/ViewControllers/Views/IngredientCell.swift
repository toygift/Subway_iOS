//
//  IngredientCell.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher

class IngredientCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    
    var ingredientList = [Any]() {
        didSet {
            self.ingredientTableView.delegate = self
            self.ingredientTableView.dataSource = self
            
            self.ingredientTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data:Ranking) {
//        print("IngredientCell",data)
//        self.ingredientLabel.text = "가나다"
        self.ingredientList.append(data.sandwich.mainIngredient)
        self.ingredientList.append(data.bread)
        self.ingredientList.append(data.cheese)
        self.ingredientList.append(data.toppings)
        self.ingredientList.append(data.vegetables)
        self.ingredientList.append(data.sauces)
    }
}
extension IngredientCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("aa",ingredientList)
        return self.ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detaillist", for: indexPath) as! IngredientCell
//        cell.setData(<#T##data: Ranking##Ranking#>)
        return cell
    }
    
}

class IngredientColCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData(_ data: Bread) {
        print("IngredientColCell",data)
        let url = data.image
        self.imageView.kf.setImage(with: URL(string: url)!)
    }
}
extension IngredientColCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailcell", for: indexPath) as! IngredientColCell
//        cell.setData(self.ingredientList[indexPath.item])
        
        return cell
    }
}
