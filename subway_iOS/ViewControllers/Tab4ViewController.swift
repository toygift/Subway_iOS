//
//  Tab4ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 10..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

enum MemuList: String {
    case name = "이름"
    case setting = "설정"
    
    static func getList() -> [String] {
        return [MemuList.name.rawValue, MemuList.setting.rawValue]
    }
    static func getLists() -> [MemuList] {
        return [.name, .setting]
    }
}


class Tab4ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func logout(_ sender: UIBarButtonItem) {
        TokenAuth.delete(serviceName, account: TokenAuth.SERVER_TOKEN)
        goToAuth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    fileprivate func goToAuth(){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = vc
        }
    }
}
extension Tab4ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemuList.getList().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell {
            cell.setting(with: MemuList.getList()[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch MemuList.getLists()[indexPath.row] {
        case .name:
            print("name")
        case .setting:
            print("setting")
        }
    }
}


class SettingTableViewCell: UITableViewCell {
    static let identifier = "MENUCELL"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setting(with data: String) {
        self.titleLabel.text = data
    }
}
