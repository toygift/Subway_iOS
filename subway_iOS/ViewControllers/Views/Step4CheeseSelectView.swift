//
//  Step4CheeseSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct CheeseInstance {
    var cheese : Bread?
    var clicked = false
}

protocol Step4CompleteDelegate {
    func step4Completed(cheese : Bread)
}

class Step4CheeseSelectView: UITableView {

    var list = [CheeseInstance]()
    
    let cellHeight : CGFloat = 270
    
    var completeDelegate : Step4CompleteDelegate?
    
    func setupTableView(){
        separatorStyle = .none
        register(UINib(nibName: RecipeCheeseCell.cellId, bundle: nil), forCellReuseIdentifier: RecipeCheeseCell.cellId)
        delegate = self
        dataSource = self
        
        // MARK: - prevent jumpy scrolling when reload data
        rowHeight = cellHeight
        estimatedRowHeight = cellHeight
    }
    
    func fetchData(){
        
        guard list.isEmpty else {
            return
        }
        
        GetCheeses(method: .get, parameters: [:]).requestAPI { [weak self] (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                print("ERROR GETTING CHEESES")
                return
            }
            
            if let value = response.value {
                self?.list.append(contentsOf: value.results.map({CheeseInstance(cheese: $0, clicked: false)}))
                self?.reloadData()
            }
        }
    }
    
    
}

extension Step4CheeseSelectView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCheeseCell.cellId, for: indexPath) as! RecipeCheeseCell
        cell.data = list[indexPath.row]
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
        
        if let data = list[indexPath.row].cheese {
            completeDelegate?.step4Completed(cheese: data)
        }
    }
    
}
