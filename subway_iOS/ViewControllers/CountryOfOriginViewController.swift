//
//  CountryOfOriginViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 10. 21..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct CountryOfOrigin {
    var imageName = ""
    var name = ""
    var content = ""
}


class CountryOfOriginViewController: UIViewController {

    @IBAction func back(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = [
        CountryOfOrigin(imageName: "beef", name: "쇠고기", content: "로스트 비프, 미트볼 : 호주산\n스테이크 : 미국산"),
        CountryOfOrigin(imageName: "pork", name: "돼지고기", content: "베이컨, 살라미, 페퍼로니, 풀드포크 : 미국산\n햄 : 외국산(독일, 네덜란드, 미국)과 국내산 섞음"),
        CountryOfOrigin(imageName: "chicken", name: "닭고기", content: "치킨 브레스트, 치킨 스트립, 로티세리 치킨 : 미국산"),
        CountryOfOrigin(imageName: "turkey", name: "칠면조고기", content: "터키 : 외국산(헝가리, 칠레, 미국)")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("country of origin!!")
        setupTableView()
    }
    
    fileprivate func setupTableView(){
        tableView.register(UINib(nibName: CountryOfOriginCell.cellId, bundle: nil), forCellReuseIdentifier: CountryOfOriginCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension CountryOfOriginViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryOfOriginCell.cellId) as! CountryOfOriginCell
        cell.data = list[indexPath.row]
        return cell
    }
}

