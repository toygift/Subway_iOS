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
    
    @IBAction func cancelCollection(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
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
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionTextField.becomeFirstResponder()
    }
}
