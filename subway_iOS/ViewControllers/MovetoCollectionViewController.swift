//
//  MovetoCollectionViewController.swift
//  subway_iOS
//
//  Created by Jaeseong on 06/10/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit
import Alamofire

class MovetoCollectionViewController: UIViewController {
    
    var moveToCollection: [BookmarkFilter] = []

    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelMoveCollection(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func stopMove(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("디스미스")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.moveToCollection.remove(at: 0)
    }
}
extension MovetoCollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moveToCollection.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MOVETO", for: indexPath) as? MovetoCollectionCell {
            cell.titleLabel.text = self.moveToCollection[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parameters: Parameters = ["bookmarked_recipe":self.moveToCollection[indexPath.item].id]
        let getCollection = GetCollection(api: "user/12/collection/\(self.moveToCollection[indexPath.item].id)",method: .patch, parameters: parameters)
        getCollection.requestAPIb { (response) in
            print(response)
            if let results = response.result.value {
                for data in results.bookmarkedRecipe {
                    print("ㅇㅇㅇㅇㅇ",data)
                    var ingri = [[Bread]]()
                    var name: Name!
                    var image: Sandwich!
                    ingri.append(data.sandwich.mainIngredient)
                    ingri.append([data.bread])
                    ingri.append(data.toppings)
                    ingri.append([data.cheese])
                    ingri.append([data.toasting])
                    ingri.append(data.vegetables)
                    ingri.append(data.sauces)
                    print(data.sandwich.mainIngredient.count)
                    print(data.toppings.count)
                    print(data.vegetables.count)
                    print(data.sauces.count)
                    name = data.name
                    image = data.sandwich
//                    let tt: [String : Any] = ["main":ingri,"name":name,"image":image,"isOpened":false]
//                    self.moveToCollection.append(tt)
                }
                self.tableView.reloadData()
            }
        }
    }
}
class MovetoCollectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
}
