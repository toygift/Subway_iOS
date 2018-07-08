//
//  Ranking.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 6. 24..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation
import Foundation

struct Rankings: Codable {
    let count: Int
    let next: JSONNull?
    let results: [Ranking]
    let previous: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case next, count, previous
        case results = "results"
    }
}

struct Ranking: Codable {
    let id: Int
    let name: Name
    let sandwich: Sandwich
    let bread, cheese: Bread
    let toppings: [Bread]
    let toasting: Bool
    let vegetables, sauces: [Bread]
    let inventor: Inventor
    let authUserLikeState, authUserBookmarkState: String
    let likeCount, bookmarkCount, likeBookmarkCount: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, sandwich, bread, cheese, toppings, toasting, vegetables, sauces, inventor
        case authUserLikeState = "auth_user_like_state"
        case authUserBookmarkState = "auth_user_bookmark_state"
        case likeCount = "like_count"
        case bookmarkCount = "bookmark_count"
        case likeBookmarkCount = "like_bookmark_count"
        case createdDate = "created_date"
    }
}

struct Bread: Codable {
    let id: Int
    let name, image, image3X: String
    let quantity: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case image3X = "image3x"
        case quantity
    }
}

struct Inventor: Codable {
    let id: Int
    let username: String
}

struct Name: Codable {
    let id: Int
    let name: String
}

struct Sandwich: Codable {
    let id: Int
    let name, imageLeft, image3XLeft, imageRight: String
    let image3XRight: String
    let mainIngredient: [Bread]
    let category: [Category]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageLeft = "image_left"
        case image3XLeft = "image3x_left"
        case imageRight = "image_right"
        case image3XRight = "image3x_right"
        case mainIngredient = "main_ingredient"
        case category
    }
}

struct Category: Codable {
    let name: String
}

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
