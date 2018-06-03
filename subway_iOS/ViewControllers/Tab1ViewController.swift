//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
// TODO: -
class Tab1ViewController: UIViewController {

    @IBAction func kaLogin(_ sender: UIButton) {
        let session = KOSession.shared()
        // 로그인 세션이 생성 되었으면
        if let s = session {
            // 이전 열린 세션은 닫고
            if s.isOpen() {
                s.close()
            }
            s.open(completionHandler: { [weak self] (error) in
                // 에러가 없으면
                if error == nil {
                    print("노 에러")
                    // 로그인 성공
                    if s.isOpen() {
                        print("성공",s.token.accessToken)
                        self?.requestKaLogin(accessToken: s.token.accessToken)
                    }
                        // 로그인 실패
                    else{
                        print("실패")
                    }
                }
                    // 로그인 에러//
                else {
                    print("Error login: \(error!)")
                }
            })
        }
            // 세션 생성 실패
        else {
            print("Something wrong")
        }
    }
    @IBAction func fbLogin(_ sender:UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.email], viewController: self) { [weak self] (result) in
            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                print(grantedPermissions)
                print(declinedPermissions)
                print("token",accessToken.authenticationToken)
                self?.requestFBLogin(accessToken: accessToken.authenticationToken)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tab1")
        
        
        
//        if let infoDic = Bundle.main.infoDictionary {
//            let currentBuildSetting = infoDic["CURRENT_BUILD_SETTING"] as! String
//            print(currentBuildSetting)
//        }
        
        if let currentBuild = Bundle.main.object(forInfoDictionaryKey: "CurrentBuildSetting") as? String {
            print(currentBuild)
        }
    }
    
    fileprivate func requestFBLogin(accessToken : String){
        let fbLogin = FbLogin(method: .post, parameters: ["access_token":accessToken])
        fbLogin.requestAPI { (response) in
            print(response)
        }
    }
    fileprivate func requestKaLogin(accessToken : String){
        let kaLogin = KaLogin(method: .post, parameters: ["access_token":accessToken])
        kaLogin.requestAPI { (response) in
            print("kakao",response)
        }
    }
}
