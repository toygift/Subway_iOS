//
//  Step1SandwichSelectTableView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 21..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct SandwichInstance {
    var sandwich : Sandwich?
    var clicked = false
}

protocol Step1CompleteDelegate {
    func step1Completed(sandwich : Sandwich)
}

class Step1SandwichSelectView: UIView {
    
    var category = [Filter(name: "모두", clicked: true),
                    Filter(name: "신제품", clicked: false),
                    Filter(name: "프로모션", clicked: false),
                    Filter(name: "클래식", clicked: false),
                    Filter(name: "프레쉬&라이트", clicked: false),
                    Filter(name: "프리미엄", clicked: false),
                    Filter(name: "아침메뉴", clicked: false)]
    
    var list = [SandwichInstance]()
    
    var page = 1
    var hasNextPage = false
    
    var delegate : Step1CompleteDelegate?
    
    let filterButtonCell = "FilterButtonCell"
    let rowHeight : CGFloat = 231
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    class func initializeFromNib() -> Step1SandwichSelectView {
        return UINib(nibName: "Step1SandwichSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step1SandwichSelectView
    }
    
    override func awakeFromNib() {
        collectionView.register(UINib(nibName: filterButtonCell, bundle: nil), forCellWithReuseIdentifier: filterButtonCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(UINib(nibName: RecipeSandwichCell.cellId, bundle: nil), forCellReuseIdentifier: RecipeSandwichCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - prevent jumpy scrolling when reload data
        tableView.rowHeight = rowHeight
        tableView.estimatedRowHeight = rowHeight
        
        getSandwiches(category: "", page: page)
    }
    
    fileprivate func getSandwiches(category: String, page : Int){
        let parameters : [String : Any] = ["category" : category, "page" : page]
        
        GetSandWiches(method: .get, parameters: parameters).requestAPI { [weak self] (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                print("ERROR GETTING SANDWICHES") // show error message
                return
            }
            
            if page == 1 {
                self?.list.removeAll()
            }
            
            if let value = response.value {
                self?.hasNextPage = (value.next != nil)
                self?.list.append(contentsOf: value.results.map({SandwichInstance(sandwich: $0, clicked: false)
                }))
                self?.tableView.reloadData()
            }
        }
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

        let querystring = category[indexPath.item].getQueryString()
        page = 1
        getSandwiches(category: querystring, page: page)
    }
}

extension Step1SandwichSelectView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeSandwichCell.cellId) as! RecipeSandwichCell
        cell.data = list[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if list[indexPath.row].clicked {
            return
        }
        
        for i in 0..<list.count {
            list[i].clicked = false
        }
        list[indexPath.item].clicked = true
        
        tableView.reloadData()
        
        if let data = list[indexPath.item].sandwich {
            delegate?.step1Completed(sandwich: data)
        }
    }
    
    // load more 로직
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            if hasNextPage {
                page = page + 1
                let filter = category.filter { $0.clicked }.first
                if let c = filter {
                    getSandwiches(category: c.getQueryString(), page: page)
                }
            }
        }
    }
}


