//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
class Tab1ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    var rankingList = [Ranking]() {
    
    @IBAction func searchBar(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Filter", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
           vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func filter(_ sender: UIBarButtonItem) {
        if let vc = UIStoryboard(name: "Filter", bundle: nil).instantiateInitialViewController() {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    var rankingList: [[String:Any]] = [[String:Any]]() {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        let getRankings = GetRanking(method: .get, parameters: [:])
        getRankings.requestAPI { [weak self] (response) in
            if let result = response.result.value?.results {
//                result.map({ (ranking) in
//                    ranking.sandwich.mainIngredient
//                })
                for data in result {
                    var ingri = [[Bread]]()
                    var name: Name!
                    var image: Sandwich!
                    ingri.append(data.sandwich.mainIngredient)
                    ingri.append([data.bread])
                    ingri.append(data.toppings)
                    ingri.append([data.cheese])
                    ingri.append([data.toasting])
                    ingri.append(data.vegetables)
                    ingri.append(data.sauces)
                    print(data.sandwich.mainIngredient.count)
                    print(data.toppings.count)
                    print(data.vegetables.count)
                    print(data.sauces.count)
                    name = data.name
                    image = data.sandwich
                    let tt: [String : Any] = ["main":ingri,"name":name,"image":image,"isOpened":false]
                    self?.rankingList.append(tt)
                }
                self?.tableView.reloadData()
            }
        }
    }
}
extension Tab1ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("ttt",self.rankingList.count)
//        print("ranking",self.rankingList.count)
        return self.rankingList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let isOpened = self.rankingList[section]["isOpened"] as? Bool else { return 1 }
        if isOpened == true {
            return 2
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let id = self.rankingList[indexPath.section]["name"] as! Name
            if id.id % 2 == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "evens", for: indexPath) as? RankingOddCell else { return UITableViewCell() }
                cell.setData(self.rankingList[indexPath.section], type: "evens")
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "odds", for: indexPath) as? RankingOddCell else { return UITableViewCell() }
                cell.setData(self.rankingList[indexPath.section], type: "odds")
                return cell
            }
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "opened", for: indexPath) as? RankingOddDetailCell else { return UITableViewCell() }
            guard let ing = self.rankingList[indexPath.section]["main"] as? [[Bread]] else { return UITableViewCell() }
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            let id = self.rankingList[indexPath.section]["name"] as! Name
            if id.id % 2 == 0 {
                cell.setData(ing, type: "evens")
            } else {
                cell.setData(ing, type: "odds")
            }
            
            cell.collectionView.reloadData()
            cell.collHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height + 60
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let isOpened = self.rankingList[indexPath.section]["isOpened"] as? Bool else { return  }
        if indexPath.row == 0 {
            if isOpened == true {
                self.rankingList[indexPath.section]["isOpened"] = false
                let section = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(section, with: .automatic)
            } else {
                self.rankingList[indexPath.section]["isOpened"] = true
                let section = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(section, with: .automatic)
            }
        }
        //        self.tableView.layoutIfNeeded()
        //        self.tableView.layoutSubviews()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension Tab1ViewController: SearchViewDelegate {
    func searchSandwich(_ name: String) {
        let api = "recipe/?ordering=\(name)"
        let search = GetSearchResult(api: api, method: .get, parameters: [:])
        search.requestAPIa { (response) in
            print("ㅋ",response)
            if let result = response.result.value?.results {
                self.rankingList.removeAll()
                print("123",response)
                for data in result {
                    var ingri = [[Bread]]()
                    var name: Name!
                    var image: Sandwich!
                    ingri.append(data.sandwich.mainIngredient)
                    ingri.append([data.bread])
                    ingri.append(data.toppings)
                    ingri.append([data.cheese])
                    ingri.append([data.toasting])
                    ingri.append(data.vegetables)
                    ingri.append(data.sauces)
                    print(data.sandwich.mainIngredient.count)
                    print(data.toppings.count)
                    print(data.vegetables.count)
                    print(data.sauces.count)
                    name = data.name
                    image = data.sandwich
                    let tt: [String : Any] = ["main":ingri,"name":name,"image":image,"isOpened":false]
                    self.rankingList.append(tt)
                }
                self.tableView.reloadData()
            }
        }
    }
}
