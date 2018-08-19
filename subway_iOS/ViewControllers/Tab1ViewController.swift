//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var bread: [[[Bread]]] = [[[Bread]]]()
    var aa: [String:Any] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    var rankingList = [Ranking]() {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        let getRankings = GetRanking(method: .get, parameters: [:])
        getRankings.requestAPI { [weak self] (response) in
            if let result = response.result.value?.results {
                self?.rankingList = result
                for (i,data) in result.enumerated() {
                    var ingri = [[Bread]]()
                    ingri.append(data.sandwich.mainIngredient)
                    ingri.append([data.bread])
                    ingri.append(data.toppings)
                    ingri.append([data.cheese])
                    ingri.append([data.toasting])
                    ingri.append(data.vegetables)
                    ingri.append(data.sauces)
                    self?.aa["ing"] = ingri
                }
                print("count",self?.aa["ing"])
            }
        }
    }
}
extension Tab1ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.rankingList[indexPath.row].id % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "even", for: indexPath) as! RankingEvenCell
            print("even")
            cell.setData(self.rankingList[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "odd", for: indexPath) as! RankingOddCell
            cell.setData(self.rankingList[indexPath.row])
            print("odd")
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 여기에서 ingredient tableview hidden  true/false 해야함
        var hiddenValue1 = true
        var hiddenValue2 = true
        if self.rankingList[indexPath.row].id % 2 == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! RankingEvenCell
            cell.isTableViewHidden = hiddenValue1
            hiddenValue1 = !hiddenValue1
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! RankingOddCell
            cell.isTableViewHidden = hiddenValue2
            hiddenValue2 = !hiddenValue2
        }
           self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
