//
//  Step6VegetableSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 24..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct VegetableInstance {
    var vegetable: Bread?
    var clicked = false
}

class Step6VegetableSelectView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var list = [VegetableInstance]()
    
    class func initializeFromNib() -> Step6VegetableSelectView {
        return UINib(nibName: "Step6VegetableSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step6VegetableSelectView
    }
    
    override func awakeFromNib() {
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        tableView.register(UINib(nibName: RecipeVegetableCell.cellId, bundle: nil), forCellReuseIdentifier: RecipeVegetableCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchData(){
        
        guard list.isEmpty else {
            return
        }
        
        GetVegetables(method: .get, parameters: [:]).requestAPI { [weak self] (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                print("ERROR GETTING VEGETABLES") // show error message
                return
            }
            
            if let value = response.value {
                self?.list.append(contentsOf: value.results.map({ VegetableInstance(vegetable: $0, clicked: false)
                }))
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension Step6VegetableSelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeVegetableCell.cellId) as! RecipeVegetableCell
        cell.data = list[indexPath.row]
        return cell
    }
    
    // TODO: - tableView에서 toggleButton을 관리해야 템플릿 재사용시에 넘어가는 일이 없음..
}

