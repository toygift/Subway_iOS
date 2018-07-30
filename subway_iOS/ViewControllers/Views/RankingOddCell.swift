//
//  RankingOddCell.swift
//  subway_iOS
//
//  Created by Jaeseong on 17/06/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher


// MARK: - 메인 테이블뷰 셀
class RankingOddCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainNumberLabel: UILabel!
    @IBOutlet weak var mainLikeButton: UIButton!
    @IBOutlet weak var mainBookmarkButton: UIButton!
    @IBOutlet weak var mainShareButton: UIButton!
    
    @IBOutlet weak var ingreTableView: UITableView!
    var ingrediendTitle = ["메인 재료","빵 선택", "치즈 선택","추가 선택", "토스팅 여부","야채 선택","소스 선택"]
   
    var ingrediendData = [[Bread]]() {
        didSet {
            self.ingreTableView.delegate = self
            self.ingreTableView.dataSource = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ingreTableView.rowHeight = UITableViewAutomaticDimension
        self.ingreTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }   
//    var isTableViewHidden = false {
//        didSet {
//            if isTableViewHidden == true {
//                self.tableViewHeightCon.constant = 0
////                self.ingreTableView.isHidden = isTableViewHidden
////                self.ingreTableView.alpha = 0
//            } else {
//                self.tableViewHeightCon.constant = 1024.5
////                self.ingreTableView.isHidden = isTableViewHidden
//            }
//        }
//    }
    func setData(_ data: Ranking) {
//        print("cellDATA입니다",data)
        let url = URL(string: data.sandwich.imageRight)// 이미지가 옵셔널? 일 이유가 있나요..? 무조건 이미지는 있을거 같은뎅..
//        self.mainImageView.kf.setImage(with: url)
//        self.mainTitleLabel.text = data.name.name
//        self.mainNumberLabel.text = String(data.id)
        
        self.ingrediendData.append(data.sandwich.mainIngredient)
        self.ingrediendData.append([data.bread])
        self.ingrediendData.append([data.cheese])
        self.ingrediendData.append(data.toppings)
        self.ingrediendData.append([data.toasting])
        self.ingrediendData.append(data.vegetables)
        self.ingrediendData.append(data.sauces)

//        self.ingreTableView.reloadData()
    }
    
    
//    @IBOutlet weak var tableViewHeightCon: NSLayoutConstraint!
    override func prepareForReuse() {
        
    //        self.ingreTableView.delegate = nil
    //        self.ingreTableView.dataSource = nil
        self.ingrediendData.removeAll()
    }
}
extension RankingOddCell {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ingrediendData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewOddCell", for: indexPath) as! RankingOddCellDetail
        cell.setData(ingrediendData[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ingrediendTitle[section]
    }

}
// MARK: - 서브 테이블뷰 셀
class RankingOddCellDetail: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var collDataCell = [Bread]() {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    func setData(_ data: [Bread]) {
        self.collDataCell = data
//        self.titleLabel.text = title
        
    }
//    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var frame = layoutAttributes.frame
//        frame.size.height = ceil(size.height)
//        layoutAttributes.frame = frame
//        return layoutAttributes
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = self.collectionView {
            let w = collectionView.frame.width - 20
            flowLayout.estimatedItemSize = CGSize(width: w, height: 85)
        }
    }
}
extension RankingOddCellDetail {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collDataCell.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailIngCollCellOdd", for: indexPath) as! RankingOddCollectionCell
        cell.setData(self.collDataCell[indexPath.item])
        
        return cell
    }


}
// MARK: - 컬렉션뷰 셀
class RankingOddCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgaeView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setData(_ data: Bread) {
        self.imgaeView.kf.setImage(with: URL(string: data.image))
        self.label.text = data.name
    }
}
