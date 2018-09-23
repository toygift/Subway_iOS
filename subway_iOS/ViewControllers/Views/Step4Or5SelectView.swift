//
//  Step4CheeseSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//  치즈 & 토스팅 선택
//

import UIKit
import Alamofire

struct SingleOptionInstance {
    var ingredient : Bread?
    var clicked = false
}

protocol Step4Or5CompleteDelegate {
    func step4Or5Completed(ingredient : Bread, nextStep: Int)
}

class Step4Or5SelectView: UITableView {

    let cellHeight : CGFloat = 270
    
    var list = [SingleOptionInstance]()
    var completeDelegate : Step4Or5CompleteDelegate?
    var step = 0
    
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
        
        if step == 4 {
            GetCheeses(method: .get, parameters: [:]).requestAPI { [weak self] in
                self?.bindData(response: $0)
            }
        } else if step == 5 {
            GetToastings(method: .get, parameters: [:]).requestAPI { [weak self] in
                self?.bindData(response: $0)
            }
        }
    }
    
    fileprivate func bindData(response: DataResponse<Ingredients>){
        guard let statusCode = response.response?.statusCode, statusCode == 200 else {
            print("ERROR GETTING CHEESES")
            return
        }
        
        if let value = response.value {
            list.append(contentsOf: value.results.map({SingleOptionInstance(ingredient: $0, clicked: false)}))
            reloadData()
        }
    }
    
}

extension Step4Or5SelectView : UITableViewDelegate, UITableViewDataSource {
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
        
        if let data = list[indexPath.row].ingredient {
            completeDelegate?.step4Or5Completed(ingredient: data, nextStep: step + 1)
        }
    }
    
}
