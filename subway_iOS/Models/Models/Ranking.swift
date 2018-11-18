//
//  Ranking.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 6. 24..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

////////
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
struct BookmarkCollections: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [BookmarkCollection]
}
struct BookmarkCollection: Codable {
    let id: Int
    let user: User
    let name: String
    let bookmarks: [Bookmark]
}
class Rankings: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Recipe]
    
}
class RankingCollection: Recipe {
    
}



class Recipe : Codable {
    
    let id: Int!
    let name: String!
    let sandwich: Sandwich!
    let bread: Ingredient!
    let toppings: [Ingredient]!
    let cheese, toasting: Ingredient!
    let vegetables, sauces: [Ingredient]!
    let inventor: Inventor!
    let authUserLikeState, authUserBookmarkState: Bool?
    let createdDate: String!
    
    private enum CodingKeys: String, CodingKey {
        case id, name, sandwich, bread, toppings, cheese, toasting, vegetables, sauces, inventor
        case authUserLikeState = "auth_user_like_state"
        case authUserBookmarkState = "auth_user_bookmark_state"
        case createdDate = "created_date"
    }
}

class Bookmark: Codable {
    
    let id: Int
    let recipe: Recipe
    let collection: Int?
    let created_date: String
    
//    let likeCount, bookmarkCount, likeBookmarkCount: Int!
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.likeCount = try container.decode(Int.self, forKey: .likeCount)
//        self.bookmarkCount = try container.decode(Int.self, forKey: .bookmarkCount)
//        self.likeBookmarkCount = try container.decode(Int.self, forKey: .likeBookmarkCount)
//        try super.init(from: decoder)
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case likeCount = "like_count"
//        case bookmarkCount = "bookmark_count"
//        case likeBookmarkCount = "like_bookmark_count"
//    }
}

struct Ingredient: Codable {
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


struct Sandwich: Codable {
    let id: Int
    let name, imageFull, image3XFull, imageLeft: String
    let image3XLeft, imageRight, image3XRight: String
    let mainIngredient: [Ingredient]
    let category: [Category]
    let servingSize, calories, sugars, protein: Int
    let saturatedFat, sodium, orderingNum: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageFull = "image_full"
        case image3XFull = "image3x_full"
        case imageLeft = "image_left"
        case image3XLeft = "image3x_left"
        case imageRight = "image_right"
        case image3XRight = "image3x_right"
        case mainIngredient = "main_ingredient"
        case category
        case servingSize = "serving_size"
        case calories, sugars, protein
        case saturatedFat = "saturated_fat"
        case sodium
        case orderingNum = "ordering_num"
    }
}

struct Category: Codable {
    let name: String
}

// MARK: Encode/decode helpers
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
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

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
