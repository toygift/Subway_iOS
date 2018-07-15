//
//  IngredientCell.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher

class IngredientCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ingredientTableView: UITableView!
    var inggg: [[Bread]]! {
        didSet {
            ingredientTableView.delegate = self
            ingredientTableView.dataSource = self
            ingredientTableView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data: Ranking) {
    }
}

extension IngredientCell {
    func numberOfSections(in tableView: UITableView) -> Int {
        return inggg.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inggg[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewDetail", for: indexPath) as! IngredientTabCell
//        cell.titleLabel.text = "메롱"
        print("데이터데이터",inggg)
        cell.data = inggg[indexPath.row]
        return cell
    }
}
class IngredientTabCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [Bread]!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
}
extension IngredientTabCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionDe", for: indexPath) as! IngredientColCell
        cell.setData(data[indexPath.item])
        return cell
    }
}

class IngredientColCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData(_ data: Bread) {
//        print("IngredientColCell",data)
        self.titleLabel.text = data.name
        let url = data.image3X
        self.imageView.kf.setImage(with: URL(string: url)!)
//        print("333333",data.image3X)
    }
}
