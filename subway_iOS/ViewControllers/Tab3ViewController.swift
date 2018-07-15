//
//  Tab3ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab3ViewController: UIViewController {

    @IBAction func showFilter(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Filter", bundle: nil).instantiateInitialViewController() {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func showSearch(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Filter", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
        present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tab3")
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
