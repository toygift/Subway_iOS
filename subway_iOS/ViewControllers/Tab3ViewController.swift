//
//  Tab3ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit


class SavedCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class Tab3ViewController: UIViewController {

    
    var collectionList = ["모두"]
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func addRecipe(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "새로운 컬렉션", message: "컬렉션 이름을 만들어 주세요.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "컬렉션 이름"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alert.textFields![0]
            self.collectionList.append(textField.text ?? "")
            self.collectionView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showFilter(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Filter", bundle: nil).instantiateInitialViewController() {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func showSearch(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Filter", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
        present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
extension Tab3ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedRecipe", for: indexPath) as? SavedCollectionViewCell {
            cell.titleLabel.text = self.collectionList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
}
