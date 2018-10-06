//
//  MovetoCollectionViewController.swift
//  subway_iOS
//
//  Created by Jaeseong on 06/10/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit

class MovetoCollectionViewController: UIViewController {
    
    var moveToCollection: [Filter] = []

    @IBOutlet weak var tableView: UITableView!
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
}
class MovetoCollectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
}
