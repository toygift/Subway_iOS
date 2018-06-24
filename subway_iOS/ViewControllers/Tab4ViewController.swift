//
//  Tab4ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 6. 10..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab4ViewController: UIViewController {
    
    @IBAction func logout(_ sender: UIButton) {
        TokenAuth().delete(serviceName, account: TokenAuth.SERVER_TOKEN)
        goToAuth()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TAB4")
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
    
    fileprivate func goToAuth(){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = vc
        }
    }
    
}
