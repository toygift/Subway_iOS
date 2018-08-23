//
//  Step1SandwichSelectTableView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 21..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Step1SandwichSelectView: UIView {
    
    var category = [Filter(name: "모두", clicked: true),
                    Filter(name: "신제품", clicked: false),
                    Filter(name: "프로모션", clicked: false),
                    Filter(name: "클래식", clicked: false),
                    Filter(name: "프레쉬&라이트", clicked: false),
                    Filter(name: "프리미엄", clicked: false),
                    Filter(name: "아침메뉴", clicked: false)]
    
    let filterButtonCell = "FilterButtonCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    class func initializeFromNib() -> Step1SandwichSelectView {
        return UINib(nibName: "Step1SandwichSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step1SandwichSelectView
    }
    
    override func awakeFromNib() {
        
        collectionView.register(UINib(nibName: filterButtonCell, bundle: nil), forCellWithReuseIdentifier: filterButtonCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension Step1SandwichSelectView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterButtonCell, for: indexPath) as! FilterButtonCell
        cell.label.text = category[indexPath.item].name
        cell.clicked = category[indexPath.item].clicked
        cell.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = category[indexPath.item].name.count * 10 + 35
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<category.count {
            category[i].clicked = indexPath.item != i ? false : true
        }
        collectionView.reloadData()
    }
}

extension Step1SandwichSelectView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


