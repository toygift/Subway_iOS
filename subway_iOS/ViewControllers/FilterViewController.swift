//
//  FilterViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit


class FilterViewController: UIViewController {

    @IBOutlet weak var sortRankingBtn: FilterButton!
    @IBOutlet weak var sortHeartBtn: FilterButton!
    @IBOutlet weak var sortSaveBtn: FilterButton!
    @IBOutlet weak var sortLastRegisteredBtn: FilterButton!
    
    @IBAction func closeBtnClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupViews(){
        
    }
    
    fileprivate func setupEvents(){
        
    }
    
    
    
}
