//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rankingList = [Ranking]() {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    var ingredientList = [[Bread]]() {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        let getRankings = GetRanking(method: .get, parameters: [:])
        getRankings.requestAPI { [weak self] (response) in
            if let result = response.result.value?.results {
                print("ranking",result)
                self?.rankingList = result
                for (_,data) in ((self?.rankingList)?.enumerated())! {
                    print("da",data)
                    var aa = [Bread]()
                    aa.append(data.bread)
                    aa.append(data.cheese)
                    aa.append(contentsOf: data.sandwich.mainIngredient)
                    aa.append(contentsOf: data.vegetables)
                    aa.append(contentsOf: data.toppings)
                    aa.append(data.toasting)
                    aa.append(contentsOf: data.sauces)
                    
                    self?.ingredientList.append(aa)
                }
                
                print("123123123",self?.ingredientList)
//                for i in result.enumerated() {
//                    self?.ingredientList.append(i.sandwich.mainIngredient)
//                    self?.ingredientList.append(i.sauces)
//                    self?.ingredientList.append(i.vegetables)
//                }
            }
        }
     
    }
}
extension Tab1ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "odd", for: indexPath) as? RankingOddCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as? IngredientCell
        cell?.setData(self.rankingList[indexPath.row])
        let test = self.rankingList[indexPath.row]
        cell?.inggg = self.ingredientList
        print("가너ㅏ더",self.ingredientList[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
