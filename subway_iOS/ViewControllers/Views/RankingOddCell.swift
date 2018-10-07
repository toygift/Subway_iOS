//
//  RankingOddCell.swift
//  subway_iOS
//
//  Created by Jaeseong on 17/06/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

// MARK: - 메인 테이블뷰 셀
class RankingOddCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainNumberLabel: UILabel!
    
    
    @IBOutlet weak var mainLikeButton: UIButton!
    @IBOutlet weak var mainBookmarkButton: UIButton!
    @IBOutlet weak var mainShareButton: UIButton!
    @IBAction func checkBookmark(_ sender: UIButton) {
        print("check")
       alamo()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func alamo() {
        let url = "http://subway-eb.ap-northeast-2.elasticbeanstalk.com/user/12/bookmark/"
        let headers = ["Authorization":"Token 08df49014bb9055fb6911484a183deb67c76cbd7"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: headers).responseJSON { (response) in
            let json = JSON(response.result.value)
            print(json)
        }
    }
    func setData(_ data: [String:Any], type: String) {
        let aa = data["image"] as! Sandwich
        let name = data["name"] as! Name
        print(name)
        if type == "evens" {
            self.mainImageView.kf.setImage(with: URL(string: aa.image3XLeft))
        } else {
            self.mainImageView.kf.setImage(with: URL(string: aa.image3XRight))
        }
        
        self.mainTitleLabel.text = name.name
        self.mainNumberLabel.text = String(name.id)
    }
}
class RankingOddDetailCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var left: NSLayoutConstraint!
    @IBOutlet weak var right: NSLayoutConstraint!
    @IBOutlet weak var collHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bookmakrButton: UIButton!
   
    var ingrediendTitle = ["메인 재료","빵 선택", "치즈 선택","추가 선택", "토스팅 여부","야채 선택","소스 선택"]
    var ingrediendData = [[Bread]]() {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
        }
    }
    
    func setData(_ data: [[Bread]], type: String) {
        self.ingrediendData = data
        if type == "odds" {
//            self.left.constant = 20
//            self.right.constant = 0
        } else {
//            self.right.constant = 20
//            self.left.constant = 0
        }
    }
}
extension RankingOddDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.ingrediendData.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ingrediendData[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCells", for: indexPath) as! RankingOddCollectionCell
        cell.setData(self.ingrediendData[indexPath.section][indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.sectionTitle.text = ingrediendTitle[indexPath.section]
            print(ingrediendTitle[indexPath.section])
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}
class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionTitle: UILabel!

}
// MARK: - 컬렉션뷰 셀
class RankingOddCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgaeView: UIImageView!
    @IBOutlet weak var label: UILabel!

    func setData(_ data: Bread) {
        self.imgaeView.kf.setImage(with: URL(string: data.image3X))
        self.label.text = data.name
        self.contentView.setNeedsLayout()
    }
}
