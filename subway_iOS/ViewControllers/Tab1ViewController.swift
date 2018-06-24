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
        if let token = TokenAuth().load(serviceName, account: TokenAuth.SERVER_TOKEN) {
            let getRanking = GetRanking(method: .get, parameters: ["Authorization":token])
            getRanking.requestAPI { [weak self] (response) in
                print(response)
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
