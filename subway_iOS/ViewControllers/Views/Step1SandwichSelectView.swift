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

extension Step1SandwichSelectView : UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    // TODO: - duplicate logic for category collectionview
}

extension Step1SandwichSelectView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


