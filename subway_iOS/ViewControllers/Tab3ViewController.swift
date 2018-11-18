//
//  Tab3ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//struct BookmarkInstance {
//    var recipe : Recipe
//    var isOpened = false
//
//    init(recipe : Recipe) {
//        self.recipe = recipe
//    }
//}


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
    func setCollectionCell(_ data: BookmarkFilter) {
        self.titleLabel.text = data.name
        self.cellSelected = data.clicked
    }
}

class Tab3ViewController: UIViewController {

    var collectionList = [BookmarkFilter]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var bookmarkList: [RankingInstance] = [RankingInstance]() {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addRecipe(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: MAKECOLLECTION, sender: nil)
    }
    @IBAction func text(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: MOVETOCOLLECTION, sender: self.collectionList)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MAKECOLLECTION {
            if let nextViewController = segue.destination as? MakeCollectionViewController {
                nextViewController.delegate = self
            }
        } else if segue.identifier == MOVETOCOLLECTION {
            if let nextViewController = segue.destination as? MovetoCollectionViewController {
                if let nextView = sender as? [String: Any] {
                    nextViewController.moveToCollection = nextView["list"] as! [BookmarkFilter]
                    nextViewController.moveToRecipeId = nextView["recipe"] as! Int
                }
//                nextViewController.delegate = self
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getCollections()
        getDefaultCollection()
    }
    
    fileprivate func getCollections(){
        collectionList.removeAll()
        let userId = "7" // TODO: - get it from TokenAuth
        let getCollections = GetCollections(api: "user/\(userId)/collection", method: .get, parameters: [:])
        getCollections.requestAPIb { [weak self] (response) in
            
            if let results = response.result.value?.results {
                for data in results.sorted(by: {$0.id < $1.id}) {
                    if data.name == "default" {
                        self?.collectionList.append(BookmarkFilter(id: data.id, name: "기본", clicked: true))
                    } else {
                        self?.collectionList.append(BookmarkFilter(id: data.id, name: data.name, clicked: false))
                    }
                }
                self?.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func getDefaultCollection(){
        bookmarkList.removeAll()
        GetCollection(api: "user/7/collection/default", method: .get, parameters: [:]).requestAPIb { [weak self] (response) in
            if let bookmarks = response.result.value?.bookmarks {
                self?.bookmarkList = bookmarks.map{ RankingInstance(recipe: $0.recipe) }
                self?.tableView.reloadData()
            }
        }
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
extension Tab3ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("ttt",self.bookmarkList.count)
        return self.bookmarkList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isOpened = self.bookmarkList[section].isOpened
        if isOpened == true {
            return 2
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = self.bookmarkList[indexPath.section].recipe.id as! Int
        if indexPath.row == 0 {
            if id % 2 == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "evens", for: indexPath) as? RankingOddCell else { return UITableViewCell() }
                cell.setData(self.bookmarkList[indexPath.section], type: "evens")
                cell.delegate = self
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "odds", for: indexPath) as? RankingOddCell else { return UITableViewCell() }
                cell.setData(self.bookmarkList[indexPath.section], type: "odds")
                cell.delegate = self
                return cell
            }
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "opened", for: indexPath) as? RankingOddDetailCell else { return UITableViewCell() }
            let ing = self.bookmarkList[indexPath.section]
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            if id % 2 == 0 {
                cell.setData(ing, type: "evens")
            } else {
                cell.setData(ing, type: "odds")
            }
            
            cell.collectionView.reloadData()
            cell.collHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height + 60
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let isOpened = self.bookmarkList[indexPath.section].isOpened as? Bool else { return  }
        if indexPath.row == 0 {
            if isOpened == true {
                self.bookmarkList[indexPath.section].isOpened = false
                let section = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(section, with: .none)
            } else {
                self.bookmarkList[indexPath.section].isOpened = true
                let section = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(section, with: .none)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension Tab3ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedRecipe", for: indexPath) as? SavedCollectionViewCell {
            cell.setCollectionCell(self.collectionList[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<self.collectionList.count {
            self.collectionList[i].clicked = indexPath.item != i ? false : true
        }
        if indexPath.item == 0 {
            getDefaultCollection()
        } else {
            let getCollection = GetCollection(api: "user/7/collection/\(self.collectionList[indexPath.item].id)",method: .get, parameters: [:])
            getCollection.requestAPIb { [weak self] (response) in
                if let results = response.result.value {
                    self?.bookmarkList.removeAll()
                    for data in results.bookmarks {
                        print("ㅇㅇㅇㅇㅇ",data)
                        self?.bookmarkList.append(RankingInstance(recipe: data.recipe))
                    }
                    self?.tableView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
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
        //getCollections()
//        self.collectionList.append(BookmarkFilter(id: <#Int#>, name: input, clicked: false))// 요건 추후 삭제
        self.alamo(input)
    }
    func alamo(_ name: String) {
        //USER의 id 저장해서 URL에 뿔리기
        //        let url = "http://subway-eb.ap-northeast-2.elasticbeanstalk.com/user/\(User.id)/collection/"
        let url = "https://api.my-subway.com/user/7/collection/"
        let headers: HTTPHeaders = ["Authorization":"Token b5dd7a7e9b23670dfc64383351ca87f4a3fc8139"]
        let parameters: Parameters = ["name": name]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: headers).responseJSON { [weak self] (response) in
            // 리스폰스 받아서 컬렉션 뷰에 추가 (Filter)
            // TODO: - 객체 하나만 append <js>
            self?.getCollections()
        }
    }
}
extension Tab3ViewController: MoveTOCollectionDelegate {
    func moveToCollection(recipe id: Int) {
        print("오오오오오오옹",id)
        self.performSegue(withIdentifier: MOVETOCOLLECTION, sender: ["list":self.collectionList,"recipe":id])
    }
}
