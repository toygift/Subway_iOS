//
//  Tab4ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 10..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct Setting {
    var title = ""
    var imageName = ""
}

class Tab4ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
//    @IBAction func logout(_ sender: UIBarButtonItem) {
//        TokenAuth.delete(serviceName, account: TokenAuth.SERVER_TOKEN)
//        goToAuth()
//    }
    
    var settingList = [Setting(title: "공지사항", imageName: "clipboard"),
                       Setting(title: "원산지 정보", imageName: "compass"),
                       Setting(title: "알레르기 정보", imageName: "pill"),
                       Setting(title: "로그아웃", imageName: "logOut"),
                       Setting(title: "회원탈퇴", imageName: "userX")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = 55
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
        return settingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell {
            cell.setting(with: settingList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = settingList[indexPath.row].title
        print(title)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


class SettingTableViewCell: UITableViewCell {
    static let identifier = "MENUCELL"
    
    @IBOutlet weak var logoIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setting(with data: Setting) {
        self.titleLabel.text = data.title
        self.logoIV.image = UIImage(named: data.imageName)
    }
}
