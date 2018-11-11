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
protocol MoveTOCollectionDelegate: class {
    func moveToCollection(recipe id: Int)
}
class RankingOddCell: UITableViewCell {
    
    weak var delegate: MoveTOCollectionDelegate?
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainNumberLabel: UILabel!
    
    var recipeId: Int!
    @IBOutlet weak var mainLikeButton: UIButton!
    @IBOutlet weak var mainBookmarkButton: UIButton!
    @IBOutlet weak var mainShareButton: UIButton!
    @IBAction func checkBookmark(_ sender: UIButton) {
        print("check")
        alamo()
    }
    
    @IBAction func movingCollection(_ sender: Any) {
        self.delegate?.moveToCollection(recipe: self.recipeId)
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func alamo() {
        let url = "https://api.my-subway.com/user/7/bookmark/"
        let headers = ["Authorization":"Token b5dd7a7e9b23670dfc64383351ca87f4a3fc8139"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: headers).responseJSON { (response) in
            let json = JSON(response.result.value)
            print(json)
        }
    }
    func setData(_ data: RankingInstance, type: String) {
        self.recipeId = data.recipe.id
        print("레이디가가가가가",data.recipe.sandwich)
        if type == "evens" {
            self.mainImageView.kf.setImage(with: URL(string: data.recipe.sandwich.image3XLeft))
        } else if type == "odds" {
            self.mainImageView.kf.setImage(with: URL(string: data.recipe.sandwich.image3XRight))
        } else {
            self.mainImageView.kf.setImage(with: URL(string: data.recipe.sandwich.imageFull))
        }
        
        self.mainTitleLabel.text = data.recipe.name
        
        self.mainNumberLabel.text = recipeId! > 9 ? "\(recipeId!)" : "0\(recipeId!)"
    }
}
class RankingOddDetailCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var left: NSLayoutConstraint!
    @IBOutlet weak var right: NSLayoutConstraint!
    @IBOutlet weak var collHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bookmakrButton: UIButton!
   
    var ingredientTitle = ["메인 재료","빵 선택", "치즈 선택","추가 선택", "토스팅 여부","야채 선택","소스 선택"]
    var ingredientData : RankingInstance? {
        didSet {
            convertData()
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
        }
    }
    
    var ingredientArray = [[Ingredient]]()
    
    fileprivate func convertData(){
        guard let data = ingredientData?.recipe else {
            fatalError("data has not been set")
        }
        ingredientArray.removeAll()
        ingredientArray.append(data.sandwich.mainIngredient)
        ingredientArray.append([data.bread])
        ingredientArray.append(data.toppings)
        ingredientArray.append([data.cheese])
        ingredientArray.append([data.toasting])
        ingredientArray.append(data.vegetables)
        ingredientArray.append(data.sauces)
        
    }
    
    func setData(_ data: RankingInstance, type: String) {
        self.ingredientData = data
    }
}
extension RankingOddDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.ingredientArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ingredientArray[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCells", for: indexPath) as! RankingOddCollectionCell
        cell.setData(self.ingredientArray[indexPath.section][indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.sectionTitle.text = ingredientTitle[indexPath.section]
            print(ingredientTitle[indexPath.section])
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

    func setData(_ data: Ingredient) {
        self.imgaeView.kf.setImage(with: URL(string: data.image3X))
        self.label.text = data.name
        self.contentView.setNeedsLayout()
    }
}
