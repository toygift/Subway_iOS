//
//  Ranking.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 6. 24..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

struct Name: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
struct Inventor: Codable {
    let id: Int?
    let username: String?
//    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
//        case email = "email"
    }
}
struct Sandwich: Codable {
    let id: Int?
    let name: String?
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
    }
}
struct Bread: Codable {
    let id: Int?
    let name: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
    }
}
struct Vegetables: Codable {
    let id: Int?
    let name: String?
    let quantity: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case quantity = "quantity"
        case image = "image"
    }
}
struct Ranking: Codable {
    let id: Int?
    let name: Name?
    let inventor: Inventor?
    let sandwich: Sandwich
    let bread: Bread?
    let vegetables: [Vegetables]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case inventor = "inventor"
        case sandwich = "sandwich"
        case bread = "bread"
        case vegetables = "vegetables"
    }
}
struct Rankings: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Ranking]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case results = "results"
        case next = "next"
        case previous = "previous"
        
    }
}
