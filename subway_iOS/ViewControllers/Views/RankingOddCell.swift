//
//  RankingOddCell.swift
//  subway_iOS
//
//  Created by Jaeseong on 17/06/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher

class RankingOddCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainNumberLabel: UILabel!
    @IBOutlet weak var mainLikeButton: UIButton!
    @IBOutlet weak var mainBookmarkButton: UIButton!
    @IBOutlet weak var mainShareButton: UIButton!
    @IBOutlet weak var ingreTableView: UITableView!
    var ingrediendData: [[Bread]]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ingrediendData = [[Bread]]()
        self.ingreTableView.delegate = self
        self.ingreTableView.dataSource = self
    }
    
    
    func setData(_ data: Ranking) {
//        print("cellDATA입니다",data)
        let url = URL(string: data.sandwich.imageRight)// 이미지가 옵셔널? 일 이유가 있나요..? 무조건 이미지는 있을거 같은뎅..
        self.mainImageView.kf.setImage(with: url)
        self.mainTitleLabel.text = data.name.name
        self.ingrediendData.append(data.sandwich.mainIngredient)
        self.ingrediendData.append([data.bread])
        self.ingrediendData.append([data.cheese])
        self.ingrediendData.append(data.sauces)
        self.ingrediendData.append([data.toasting])
        self.ingrediendData.append(data.vegetables)
        self.ingrediendData.append(data.vegetables)
//        print("가나다라마바사",self.ingrediendData)
        self.ingreTableView.reloadData()
    }
}
extension RankingOddCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingrediendData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailIngCell", for: indexPath) as! RankingOddCellDetail
        cell.setData(ingrediendData[indexPath.row])
        return cell
    }
}
class RankingOddCellDetail: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collDataCell = [Bread]()
    func setData(_ data: [Bread]) {
        print("tableviewCell in tableview Cell",data)
        self.collDataCell = data
        self.titleLabel.text = "아아아"
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
extension RankingOddCellDetail {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collDataCell.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailIngCollCell", for: indexPath) as! RankingOddCollectionCell
        cell.setData(self.collDataCell[indexPath.item])
        return cell
    }
}
class RankingOddCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgaeView: UIImageView!
    @IBOutlet weak var label: UILabel!
    func setData(_ data: Bread) {
//        self.imgaeView.image = data.
        self.label.text = data.name
    }
}
