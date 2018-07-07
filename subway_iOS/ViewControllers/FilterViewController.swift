//
//  FilterViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit


class FilterViewController: UIViewController {

    @IBAction func closeBtnClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var sortCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    let filterButtonCell = "FilterButtonCell"
    let filterButtonCell2 = "FilterButtonCell2"
    let filterProductCell = "FilterProductCell"
    
    var sort = [Filter(name: "랭킹 많은 순", clicked: true),
                 Filter(name: "하트 많은 순", clicked: false),
                 Filter(name: "저장 많은 순", clicked: false),
                 Filter(name: "최신 등록 순", clicked: false)]
    
    var category = [Filter(name: "모두", clicked: true),
                    Filter(name: "신제품", clicked: false),
                    Filter(name: "프로모션", clicked: false),
                    Filter(name: "클래식", clicked: false),
                    Filter(name: "프레쉬&라이트", clicked: false),
                    Filter(name: "프리미엄", clicked: false),
                    Filter(name: "아침메뉴", clicked: false)]
    
    var product = [FilterProduct(image: #imageLiteral(resourceName: "product_spicyItalianAvocado"), name: "스파이시\n이탈리안 아보카도"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_turkeyBaconAvocado"), name: "터키 베이컨\n아보카도"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_veggieAvocado"), name: "베지 아보카도"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_pulledPork"), name: "풀드포크"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_eggMayo"), name: "에그마요"),
                   
                   FilterProduct(image: #imageLiteral(resourceName: "product_italianBMT"), name: "이탈리안\n비엠티"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_bLT"), name: "비엘티"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_meatball"), name: "미트볼"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_ham"), name: "햄"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_tuna"), name: "참치"),
                   
                   FilterProduct(image: #imageLiteral(resourceName: "product_rotisserieChicken"), name: "로티세리\n치킨"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_roastedChicken"), name: "로스트 치킨"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_roastedBeef"), name: "로스트 비프"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_subwayClub"), name: "써브웨이\n클럽"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_turkey"), name: "터키"),
                   
                   FilterProduct(image: #imageLiteral(resourceName: "product_veggieDelite"), name: "베지"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_steakCheese"), name: "스테이크 & 치즈"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_chickenBaconRanch"), name: "치킨 베이컨 랜치"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_subwayMelt"), name: "써브웨이 멜트"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_subwayMelt"), name: "써브웨이 멜트"),
                   
                   FilterProduct(image: #imageLiteral(resourceName: "product_turkeyBacon"), name: "터키 베이컨"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_spicyItalian"), name: "스파이시 이탈리안"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_chickenTeriyaki"), name: "치킨 데리야끼"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_blackForestHamEggCheese"), name: "블랙 포레스트햄 & 에그 치즈"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_westernEggCheese"), name: "웨스턴 에그 & 치즈"),
                   
                   FilterProduct(image: #imageLiteral(resourceName: "product_baconEggCheese"), name: "베이컨 에그 & 치즈"),
                   FilterProduct(image: #imageLiteral(resourceName: "product_steakEggCheese"), name: "스테이크 에그 & 치즈"),
                   ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

    fileprivate func setupViews(){
        sortCollectionView.delegate = self
        sortCollectionView.dataSource = self
        sortCollectionView.register(UINib(nibName: filterButtonCell, bundle: nil), forCellWithReuseIdentifier: filterButtonCell)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: filterButtonCell, bundle: nil), forCellWithReuseIdentifier: filterButtonCell2)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(UINib(nibName: filterProductCell, bundle: nil), forCellWithReuseIdentifier: filterProductCell)
    }
    
}

extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sortCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterButtonCell, for: indexPath) as! FilterButtonCell
            cell.label.text = sort[indexPath.item].name
            cell.clicked = sort[indexPath.item].clicked
            cell.tag = indexPath.item
            return cell
        } else if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterButtonCell2, for: indexPath) as! FilterButtonCell
            cell.label.text = category[indexPath.item].name
            cell.clicked = category[indexPath.item].clicked
            cell.tag = indexPath.item
            return cell
        } else if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterProductCell, for: indexPath) as! FilterProductCell
            cell.data = product[indexPath.item]
            cell.tag = indexPath.item
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sortCollectionView {
            return sort.count
        } else if collectionView == categoryCollectionView {
            return category.count
        } else if collectionView == productCollectionView {
            return product.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sortCollectionView {
            let width = (view.frame.width-20-20-6)/4
            return CGSize(width: width, height: 30)
        } else if collectionView == categoryCollectionView{
            let width = category[indexPath.item].name.count * 10 + 35
            return CGSize(width: width, height: 30)
        } else if collectionView == productCollectionView {
            let width = (view.frame.width-60)/3
            return CGSize(width: width, height: width)
        }
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sortCollectionView {
            return 2
        } else if collectionView == productCollectionView {
            return 15
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sortCollectionView {
            toggleSort(tag: indexPath.item)
        } else if collectionView == categoryCollectionView {
            toggleCategory(tag: indexPath.item)
        }
    }
    
    fileprivate func toggleSort(tag : Int) {
        for i in 0..<sort.count {
            sort[i].clicked = tag != i ? false : true
        }
        sortCollectionView.reloadData()
    }
    
    fileprivate func toggleCategory(tag : Int){
        for i in 0..<category.count {
            category[i].clicked = tag != i ? false : true
        }
        categoryCollectionView.reloadData()
    }
    
}

