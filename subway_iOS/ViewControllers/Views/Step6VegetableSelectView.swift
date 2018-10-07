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
    var selectedOption = [false, false, true, false]
    
    init(vegetable: Bread) {
        self.vegetable = vegetable
    }
}

protocol Step6CompleteDelegate {
    func step6Completed(vegetableSelection: [String: String])
}

class Step6VegetableSelectView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    var list = [VegetableInstance]()
    var completeDelegate: Step6CompleteDelegate?
    
    class func initializeFromNib() -> Step6VegetableSelectView {
        return UINib(nibName: "Step6VegetableSelectView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Step6VegetableSelectView
    }
    
    override func awakeFromNib() {
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        tableView.register(UINib(nibName: RecipeVegetableCell.cellId, bundle: nil), forCellReuseIdentifier: RecipeVegetableCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 64))
        tableView.tableFooterView = tableFooterView
        
        nextButton.addTarget(self, action: #selector(goNextStep), for: .touchUpInside)
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
                self?.list.append(contentsOf: value.results.map({ VegetableInstance(vegetable: $0)
                }))
                self?.tableView.reloadData()
            }
        }
    }
    
    func initializeSelection(){
        for i in 0..<list.count {
            if !list[i].selectedOption[2] {
                list[i].selectedOption = [false, false, true, false]
                let indexPath = IndexPath(row: i, section: 0)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
    @objc fileprivate func goNextStep(){
        var selectedOptions = [String : String]()
        for row in list {
            if let name = row.vegetable?.name {
                selectedOptions[name] = getSelectedOptionString(options: row.selectedOption)
            }
        }
        completeDelegate?.step6Completed(vegetableSelection: selectedOptions)
    }
    
    fileprivate func getSelectedOptionString(options : [Bool]) -> String {
        guard options.count == 4 else {
            fatalError("options not applicable")
        }
        
        if options[0] {
            return "빼"
        } else if options[1] {
            return "적게"
        } else if options[2] {
            return "기본"
        } else if options[3] {
            return "많이"
        }
        return ""
    }
}

extension Step6VegetableSelectView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeVegetableCell.cellId) as! RecipeVegetableCell
        cell.data = list[indexPath.row]
        cell.noButton.tag = indexPath.row
        cell.littleButton.tag = indexPath.row
        cell.defaultButton.tag = indexPath.row
        cell.muchButton.tag = indexPath.row
        
        cell.noButton.addTarget(self, action: #selector(toggleNo), for: .touchUpInside)
        cell.littleButton.addTarget(self, action: #selector(toggleLittle), for: .touchUpInside)
        cell.defaultButton.addTarget(self, action: #selector(toggleDefault), for: .touchUpInside)
        cell.muchButton.addTarget(self, action: #selector(toggleMuch), for: .touchUpInside)
        return cell
    }
    
    @objc fileprivate func toggleNo(sender: UIButton){
        let index = sender.tag
        list[index].selectedOption = [true, false, false, false]
        refreshCell(row: index)
    }
    
    @objc fileprivate func toggleLittle(sender: UIButton){
        let index = sender.tag
        list[index].selectedOption = [false, true, false, false]
        refreshCell(row: index)
    }
    
    @objc fileprivate func toggleDefault(sender: UIButton){
        let index = sender.tag
        list[index].selectedOption = [false, false, true, false]
        refreshCell(row: index)
    }
    
    @objc fileprivate func toggleMuch(sender: UIButton){
        let index = sender.tag
        list[index].selectedOption = [false, false, false, true]
        refreshCell(row: index)
    }
    
    fileprivate func refreshCell(row: Int){
        UIView.performWithoutAnimation {
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

