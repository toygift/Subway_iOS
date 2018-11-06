//
//  SearchViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 8..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchViewDelegate: class {
    func searchSandwich(_ name: String)
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewDelegate?
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchedWords = [RecentSearchWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchRecentSearchWords()
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        textField.delegate = self
    }

    fileprivate func fetchRecentSearchWords(){
        let realm = try! Realm()
        for w in realm.objects(RecentSearchWord.self) {
            searchedWords.append(w)
        }
        tableView.reloadData()
    }

}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedWordCell") as! SearchedWordCell
        cell.data = searchedWords[indexPath.row].word
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteSearchedWord(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = searchedWords[indexPath.row].word
        dismiss(animated: true) {
            [weak self] in
            self?.delegate?.searchSandwich(name)
        }
    }
    
    @objc fileprivate func deleteSearchedWord(sender: UIButton){
        let searchedWord = searchedWords.remove(at: sender.tag)
        let realm = try! Realm()
        try! realm.write {
            realm.delete(searchedWord)
        }
        tableView.reloadData()
    }
    
}

// MARK: - textfield implementation
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        var q: String = ""
        if tf == textField {
            if let empty = tf.text?.isEmpty, !empty {
                if let qt = tf.text {
                    q = qt
                }
                print("Q: ", q)
                let realm = try! Realm()
                try! realm.write {
                    let save = RecentSearchWord()
                    // user 수정해야함
                    save.user = "rr"
                    save.word = q
                    save.date = Date()
                    realm.add(save)
                }
            }
            self.dismiss(animated: true) {
                [weak self] in
                tf.resignFirstResponder()
                tf.text = ""
                self?.delegate?.searchSandwich(q)
            }
            return false
        }
        return true
    }
}

