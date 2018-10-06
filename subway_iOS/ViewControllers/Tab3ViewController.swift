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
//    @IBOutlet weak var backView: UIView!
    // 텍스트 길이 셀 width   일치
    
    var cellSelected = false {
        willSet {
            if newValue {
                self.titleLabel.textColor = UIColor.white
                self.titleLabel.backgroundColor = UIColor.yellowSelected
//                self.backView.backgroundColor = UIColor.grayForShadow
            } else {
                self.titleLabel.textColor = UIColor.grayForDisabledFilter
                self.titleLabel.backgroundColor = UIColor.clear
//                self.backView.backgroundColor = UIColor.clear
            }
        }
    }
    override func awakeFromNib() {
        self.titleLabel.layer.cornerRadius = 10
        self.titleLabel.clipsToBounds = true
    }
}

class Tab3ViewController: UIViewController {

    
    var collectionList = [Filter(name: "모두", clicked: true)] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func addRecipe(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: MAKECOLLECTION, sender: nil)
    }
    @IBAction func text(_ sender: UIButton) {
        self.performSegue(withIdentifier: MOVETOCOLLECTION, sender: self.collectionList)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MAKECOLLECTION {
            if let nextViewController = segue.destination as? MakeCollectionViewController {
                nextViewController.delegate = self
            }
        } else  if segue.identifier == MOVETOCOLLECTION {
            if let nextViewController = segue.destination as? MovetoCollectionViewController {
                if let nextView = sender as? [Filter] {
                    nextViewController.moveToCollection = nextView
                }
//                nextViewController.delegate = self
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
    }
    fileprivate func getLabelWidth(strLength : Int) -> CGFloat{
        var width : CGFloat = 0
        let labelWidth = CGFloat(strLength * 10 + 35)
        if strLength == 0 {
            width = (view.frame.width - 95) / 2
        } else {
            width = labelWidth
        }
        return width
    }
}
extension Tab3ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedRecipe", for: indexPath) as? SavedCollectionViewCell {
            cell.titleLabel.text = self.collectionList[indexPath.row].name
            cell.cellSelected = self.collectionList[indexPath.row].clicked
            print("name",self.collectionList[indexPath.row].name)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<self.collectionList.count {
            self.collectionList[i].clicked = indexPath.item != i ? false : true
        }
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getLabelWidth(strLength: collectionList[indexPath.item].name.count)
        return CGSize(width: width, height: 50)
    }
    
}
extension Tab3ViewController: MakeCollectionDelegate {
    func setCollectionName(is input: String) {
        self.collectionList.append(Filter(name: input, clicked: false))
    }
}
