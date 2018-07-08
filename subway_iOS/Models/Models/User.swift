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
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "id"
        case name = "username"
        case email = "email"
        case date = "date_joined"
    }
}

struct LoginResponse : Codable {
    let token : String?
    let user : User?
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
}

