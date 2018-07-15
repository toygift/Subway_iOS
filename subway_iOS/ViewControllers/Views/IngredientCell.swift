//
//  IngredientCell.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher

class IngredientCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var ingredientTableView: UITableView!
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    var inggg: [[Bread]]! {
        didSet {
            self.ingredientCollectionView.delegate = self
            self.ingredientCollectionView.dataSource = self
            self.ingredientCollectionView.reloadData()
        }
    }
//    var ingredientList = [Bread]() {
//        didSet {
//            self.ingredientCollectionView.delegate = self
//            self.ingredientCollectionView.dataSource = self
//            self.ingredientCollectionView.reloadData()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ingredientCollectionView.delegate = self
        self.ingredientCollectionView.dataSource = self
        self.ingredientCollectionView.reloadData()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data: Ranking) {
        self.ingredientCollectionView.delegate = self
        self.ingredientCollectionView.dataSource = self
        self.ingredientCollectionView.reloadData()
        self.ingredientLabel.text = "메인"
//        self.inggg = data
//        for i in data {
//            self.ingredientLabel.text = i.name
//        }
        print("IngredientCell",inggg)
    }
}

extension IngredientCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberofitem")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionDe", for: indexPath) as! IngredientColCell
        
        
        
        cell.setData(inggg[indexPath.item][1])


        return cell
    }
}


class IngredientColCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData(_ data: Bread) {
        print("IngredientColCell",data)
        self.titleLabel.text = data.name
        let url = data.image3X
        self.imageView.kf.setImage(with: URL(string: url)!)
        print("333333",data.image3X)
    }
}
