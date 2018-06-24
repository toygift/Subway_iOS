//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 3..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("토큰입니당당당",TokenAuth.getAuthHeaders())
        let getRankings = GetRanking(method: .get, parameters: [:])
        getRankings.requestAPI { [weak self] (response) in

            switch response.result {
            case .success(let value):
                print("가나다라마",value)
            case .failure(let error):
                print("아아아아아아",error)
            }
        }
//        let kkk: String!
//        if let ddd = TokenAuth().load(serviceName, account: TokenAuth.SERVER_TOKEN) {
//            kkk = ddd
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
