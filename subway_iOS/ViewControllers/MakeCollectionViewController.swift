//
//  MakeCollectionViewController.swift
//  subway_iOS
//
//  Created by Jaeseong on 06/10/2018.
//  Copyright © 2018 TeamSubway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MakeCollectionDelegate: class {
    func setCollectionName(is input: String)
}


class MakeCollectionViewController: UIViewController {
    
    weak var delegate: MakeCollectionDelegate?
    @IBOutlet weak var collectionTextField: UITextField!
    @IBAction func makeCollection(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if sender.tag == 0 {
                print("캔슬")
            } else {
                
                guard let collectionName = self.collectionTextField.text else { return }
                self.delegate?.setCollectionName(is: collectionName)
            }
        }
    }
    func alamo() {
        let url = "http://subway-eb.ap-northeast-2.elasticbeanstalk.com/user/12/collection/"
        let headers: HTTPHeaders = ["Authorization":"Token 08df49014bb9055fb6911484a183deb67c76cbd7"]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default , headers: headers).responseJSON { (response) in
            let json = JSON(response.result.value)
            print(json)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionTextField.becomeFirstResponder()
    }
}
