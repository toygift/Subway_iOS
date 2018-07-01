//
//  FilterViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 1..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit


class FilterViewController: UIViewController {

    @IBAction func closeBtnClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var sortCollectionView: UICollectionView!
    
    let filterButtonCell = "FilterButtonCell"
    
    var sort1 = [Filter(name: "랭킹 많은 순", clicked: true),
                 Filter(name: "하트 많은 순", clicked: false),
                 Filter(name: "저장 많은 순", clicked: false),
                 Filter(name: "최신 등록 순", clicked: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    fileprivate func setupViews(){
        sortCollectionView.delegate = self
        sortCollectionView.dataSource = self
        sortCollectionView.register(UINib(nibName: filterButtonCell, bundle: nil), forCellWithReuseIdentifier: filterButtonCell)
    }
    
}

extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sortCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterButtonCell, for: indexPath) as! FilterButtonCell
            cell.label.text = sort1[indexPath.item].name
            cell.clicked = sort1[indexPath.item].clicked
            cell.tag = indexPath.item
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sort1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-20-20)/4
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sortCollectionView {
            toggleSort1(tag: indexPath.item)
        }
    }
    
    fileprivate func toggleSort1(tag : Int) {
        for i in 0..<sort1.count {
            sort1[i].clicked = tag != i ? false : true
        }
        sortCollectionView.reloadData()
    }
    
}

