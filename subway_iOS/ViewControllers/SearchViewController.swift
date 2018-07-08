//
//  SearchViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchedWordCollectionView: UICollectionView!
    
    var dummyData = [
        "hello", "world", "lorem ipsum", "dolor sit amet", "consectetur"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews(){
        textField.leftViewMode = .always
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        textField.leftView = leftView
        let icon = UIImageView(image: #imageLiteral(resourceName: "iconSearchGrey"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(icon)
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.centerXAnchor.constraint(equalTo: leftView.centerXAnchor, constant: 4).isActive = true
        icon.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        
        searchedWordCollectionView.register(SearchedWordCell.self, forCellWithReuseIdentifier: "SearchedWordCell")
        searchedWordCollectionView.delegate = self
        searchedWordCollectionView.dataSource = self
        searchedWordCollectionView.reloadData()
    }


}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchedWordCell", for: indexPath) as! SearchedWordCell
        return cell
    }
    
}
