//
//  Tab4ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 10..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

enum SettingType: String {
    case notice   = "공지사항"
    case origin   = "원산지 정보"
    case allergy  = "알레르기 정보"
    case logout   = "로그아웃"
    case withdraw = "회원탈퇴"
}

struct Setting {
    var title : SettingType = .notice
    var imageName = ""
}

class Tab4ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var settingList = [Setting(title: .notice,   imageName: "clipboard"),
                       Setting(title: .origin,   imageName: "compass"),
                       Setting(title: .allergy,  imageName: "pill"),
                       Setting(title: .logout,   imageName: "logOut"),
                       Setting(title: .withdraw, imageName: "userX")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = 55
    }
    
    fileprivate func showAlertPopup(alertType: AlertType){
        let alert = UIStoryboard(name: "Tab2", bundle: nil).instantiateViewController(withIdentifier: AlertPopupViewController.identifier) as! AlertPopupViewController
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        alert.alertType = alertType
        alert.delegate = self
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - cell selection handling
    fileprivate func logout(){
        TokenAuth.delete(serviceName, account: TokenAuth.SERVER_TOKEN)
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch title {
        case .notice:
            
            break
        case .origin:
            performSegue(withIdentifier: "ToCountryOfOrigin", sender: self)
            break
        case .allergy:
            
            break
        case .logout:
            // TODO: - 로그아웃 스킵한 유저에 대해서 어떻게 할 것인지??
            showAlertPopup(alertType: .logout)
            break
        case .withdraw:
            
            break
        }
    }
    
}

extension Tab4ViewController: AlertPopupDelegate {
    func positiveButtonSelected(alertType: AlertType) {
        if alertType == .logout {
            logout()
        }
    }
}

class SettingTableViewCell: UITableViewCell {
    static let identifier = "MENUCELL"
    
    @IBOutlet weak var logoIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setting(with data: Setting) {
        self.titleLabel.text = data.title.rawValue
        self.logoIV.image = UIImage(named: data.imageName)
    }
}
