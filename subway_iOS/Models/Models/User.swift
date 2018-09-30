//
//  User.swift
//  subway_iOS
//
//  Created by Jaeseong on 2018. 5. 27..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

struct User: Codable {
//    let token : String?
//    let id: Int?
//    let name: String?
//    let email: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "username"
//        case email = "email"
//        case token = "token"
//    }
}

struct LoginResponse : Codable {
    let token : String?
    let id: Int?
    let name: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "username"
        case email = "email"
        case token = "token"
    }
}

