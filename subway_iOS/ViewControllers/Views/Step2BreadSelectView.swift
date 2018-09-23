//
//  Step2BreadSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct BreadInstance {
    var bread : Bread?
    var clicked = false
}

protocol Step2CompleteDelegate {
    func step2Completed(bread : Bread)
}

class Step2BreadSelectView: UITableView {
    
    var list = [BreadInstance]()
    
    let cellHeight : CGFloat = 231
    
    var completeDelegate : Step2CompleteDelegate?
    
    func setupTableView(){
        separatorStyle = .none
        register(UINib(nibName: RecipeBreadCell.cellId, bundle: nil), forCellReuseIdentifier: RecipeBreadCell.cellId)
        delegate = self
        dataSource = self
        
        // MARK: - prevent jumpy scrolling when reload data
        rowHeight = cellHeight
        estimatedRowHeight = cellHeight
    }
    
    func fetchData(){
        
        GetBreads(method: .get, parameters: [:]).requestAPI {
            [weak self]
            (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                print("ERROR GETTING BREADS")
                return
            }
            
            if let value = response.value {
                self?.list.append(contentsOf: value.results.map({BreadInstance(bread: $0, clicked: false)
                }))
                self?.reloadData()
            }
        }
    }
    
    
    
}

extension Step2BreadSelectView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeBreadCell.cellId, for: indexPath) as! RecipeBreadCell
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
        
        if let data = list[indexPath.row].bread {
            completeDelegate?.step2Completed(bread: data)
        }
    }
    
}
