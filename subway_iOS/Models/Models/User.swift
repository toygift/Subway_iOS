//
//  User.swift
//  subway_iOS
//
//  Created by Jaeseong on 2018. 5. 27..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

struct User: Codable {
    let uid: Int?
    let name: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case email = "email"
    }
}
