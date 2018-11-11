//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct RankingInstance {
    var recipe : Recipe!
    var isOpened : Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
}

class Tab1ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
    
    var rankingList: [RankingInstance] = [RankingInstance]() {
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
                for data in result.sorted(by: { $0.id < $1.id }) {
                    self?.rankingList.append(RankingInstance(recipe: data))
                }
                self?.tableView.reloadData()
            }
        }
    }
}
extension Tab1ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.rankingList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let isOpened = self.rankingList[section].isOpened as? Bool else { return 1 }
        if isOpened == true {
            return 2
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if indexPath.section % 2 == 0 {
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
            
            let data = self.rankingList[indexPath.section]
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            if indexPath.section % 2 == 0 {
                cell.setData(data, type: "evens")
            } else {
                cell.setData(data, type: "odds")
            }
            
            cell.collectionView.reloadData()
            cell.collHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height + 60
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isOpened = rankingList[indexPath.section].isOpened
        if indexPath.row == 0 {
            if isOpened {
                self.rankingList[indexPath.section].isOpened = false
                let section = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(section, with: .none)
            } else {
                self.rankingList[indexPath.section].isOpened = true
                let section = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(section, with: .none)
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
        let api = "recipe/?search=\(name)"
        let search = GetSearchResult(api: api, method: .get, parameters: [:])
        search.requestAPIa { (response) in
            print("ㅋ",response)
            if let result = response.result.value?.results {
                self.rankingList.removeAll()
                print("123",response)
                for data in result {
                    self.rankingList.append(RankingInstance(recipe: data))
                }
                self.tableView.reloadData()
            }
        }
    }
}
