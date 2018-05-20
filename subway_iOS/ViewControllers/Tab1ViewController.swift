//
//  Tab1ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController {

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
        
        
        // Do any additional setup after loading the view.
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
