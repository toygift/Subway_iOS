//
//  CountryOfOriginViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 10. 21..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class CountryOfOriginViewController: UIViewController {

    @IBAction func back(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("country of origin!!")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
