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

import Foundation

struct Rankings: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Ranking]
}

struct Ranking: Codable {
    let id: Int
    let name: Name
    let sandwich: Sandwich
    let bread: Bread
    let toppings: [Bread]
    let cheese, toasting: Bread
    let vegetables, sauces: [Bread]
    let inventor: Inventor
    let authUserLikeState, authUserBookmarkState: String
    let likeCount, bookmarkCount, likeBookmarkCount: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, sandwich, bread, toppings, cheese, toasting, vegetables, sauces, inventor
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
    let servingSize, calories, sugars, protein: Int
    let saturatedFat, sodium, orderingNum: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
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




//////////////////////////////////////
//
//struct Rankings: Codable {
//    let count: Int
//    let next, previous: JSONNull?
//    let results: [Ranking]
//    
//}
//
//struct Ranking: Codable {
//    let id: Int
//    let name: Name
//    let sandwich: Sandwich
//    let bread: Bread
//    let toppings: [Bread]
//    let cheese, toasting: Bread
//    let vegetables, sauces: [Bread]
//    let inventor: Inventor
//    let authUserLikeState, authUserBookmarkState: String
//    let likeCount, bookmarkCount, likeBookmarkCount: Int
//    let createdDate: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, sandwich, bread, toppings, cheese, toasting, vegetables, sauces, inventor
//        case authUserLikeState = "auth_user_like_state"
//        case authUserBookmarkState = "auth_user_bookmark_state"
//        case likeCount = "like_count"
//        case bookmarkCount = "bookmark_count"
//        case likeBookmarkCount = "like_bookmark_count"
//        case createdDate = "created_date"
//    }
//}
//
//struct Bread: Codable {
//    let id: Int
//    let name, image, image3X: String
//    let quantity: Quantity?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, image
//        case image3X = "image3x"
//        case quantity
//    }
//}
//
//enum Quantity: String, Codable {
//    case no = "NO"
//    case the1_Slice = "1_slice"
//    case the2_Slice = "2_slice"
//    case the4_Slice = "4_slice"
//    case the5_Slice = "5_slice"
//}
//
//struct Inventor: Codable {
//    let id: Int
//    let username: String
//}
//
//struct Name: Codable {
//    let id: Int
//    let name: String
//}
//
//struct Sandwich: Codable {
//    let id: Int
//    let name, imageLeft, image3XLeft, imageRight: String
//    let image3XRight: String
//    let mainIngredient: [Bread]
//    let category: [Category]
//    let serving_size, calories, sugars, protein, saturated_fat ,sodium, ordering_num: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case imageLeft = "image_left"
//        case image3XLeft = "image3x_left"
//        case imageRight = "image_right"
//        case image3XRight = "image3x_right"
//        case mainIngredient = "main_ingredient"
//        case category = "category"
//        case serving_size = "serving_size"
//        case calories = "calories"
//        case sugars = "sugars"
//        case protein = "protein"
//        case saturated_fat = "saturated_fat"
//        case sodium = "sodium"
//        case ordering_num = "ordering_num"
//    }
//}
//
//struct Category: Codable {
//    let name: String
//    enum CodingKeys: String, CodingKey {
//        case name
//    }
//}
//
//// MARK: Encode/decode helpers
//
//class JSONNull: Codable {
//    public init() {}
//    
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
////////////////////////////////////////////////////////////
//struct Rankings: Codable {
//    let count: Int
//    let next, previous: JSONNull?
//    let results: [Ranking]
//}
//
//struct Ranking: Codable {
//    let id: Int
//    let name: Name
//    let sandwich: Sandwich
//    let bread: Bread
//    let toppings: [Bread]
//    let cheese, toasting: Bread
//    let vegetables, sauces: [Bread]
//    let inventor: Inventor
//    let authUserLikeState, authUserBookmarkState: String
//    let likeCount, bookmarkCount, likeBookmarkCount: Int
//    let createdDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, sandwich, bread, toppings, cheese, toasting, vegetables, sauces, inventor
//        case authUserLikeState = "auth_user_like_state"
//        case authUserBookmarkState = "auth_user_bookmark_state"
//        case likeCount = "like_count"
//        case bookmarkCount = "bookmark_count"
//        case likeBookmarkCount = "like_bookmark_count"
//        case createdDate = "created_date"
//    }
//}
//
//struct Bread: Codable {
//    let id: Int
//    let name, image, image3X: String
//    let quantity: Quantity?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, image
//        case image3X = "image3x"
//        case quantity
//    }
//}
//
//enum Quantity: String, Codable {
//    case no = "NO"
//    case the1_Slice = "1_slice"
//    case the2_Slice = "2_slice"
//    case the4_Slice = "4_slice"
//    case the5_Slice = "5_slice"
//}
//
//struct Inventor: Codable {
//    let id: Int
//    let username: String
//}
//
//struct Name: Codable {
//    let id: Int
//    let name: String
//}
//
//struct Sandwich: Codable {
//    let id: Int
//    let name, imageLeft, image3XLeft, imageRight: String
//    let image3XRight: String
//    let mainIngredient: [Bread]
//    let category: [Category]
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case imageLeft = "image_left"
//        case image3XLeft = "image3x_left"
//        case imageRight = "image_right"
//        case image3XRight = "image3x_right"
//        case mainIngredient = "main_ingredient"
//        case category
//    }
//}
//
//struct Category: Codable {
//    let name: String
//}
//
//// MARK: Encode/decode helpers
//
//class JSONNull: Codable {
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
////import Foundation
////
////struct Rankings: Codable {
////    let count: Int
////    let next: JSONNull?
////    let results: [Ranking]
////    let previous: JSONNull?
////
////    enum CodingKeys: String, CodingKey {
////        case next, count, previous
////        case results = "results"
////    }
////}
////
////struct Ranking: Codable {
////    let id: Int
////    let name: Name
////    let sandwich: Sandwich
////    let bread, cheese: Bread
////    let toppings: [Bread]
////    let toasting: Bool
////    let vegetables, sauces: [Bread]
////    let inventor: Inventor
////    let authUserLikeState, authUserBookmarkState: String
////    let likeCount, bookmarkCount, likeBookmarkCount: Int
////    let createdDate: String
////
////    enum CodingKeys: String, CodingKey {
////        case id, name, sandwich, bread, cheese, toppings, toasting, vegetables, sauces, inventor
////        case authUserLikeState = "auth_user_like_state"
////        case authUserBookmarkState = "auth_user_bookmark_state"
////        case likeCount = "like_count"
////        case bookmarkCount = "bookmark_count"
////        case likeBookmarkCount = "like_bookmark_count"
////        case createdDate = "created_date"
////    }
////}
////
////struct Bread: Codable {
////    let id: Int
////    let name, image, image3X: String
////    let quantity: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, name, image
////        case image3X = "image3x"
////        case quantity
////    }
////}
////
////struct Inventor: Codable {
////    let id: Int
////    let username: String
////}
////
////struct Name: Codable {
////    let id: Int
////    let name: String
////}
////
////struct Sandwich: Codable {
////    let id: Int
////    let name, imageLeft, image3XLeft, imageRight: String
////    let image3XRight: String
////    let mainIngredient: [Bread]
////    let category: [Category]
////
////    enum CodingKeys: String, CodingKey {
////        case id, name
////        case imageLeft = "image_left"
////        case image3XLeft = "image3x_left"
////        case imageRight = "image_right"
////        case image3XRight = "image3x_right"
////        case mainIngredient = "main_ingredient"
////        case category
////    }
////}
////
////struct Category: Codable {
////    let name: String
////}
////
////class JSONNull: Codable {
////    public init() {}
////
////    public required init(from decoder: Decoder) throws {
////        let container = try decoder.singleValueContainer()
////        if !container.decodeNil() {
////            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
////        }
////    }
////
////    public func encode(to encoder: Encoder) throws {
////        var container = encoder.singleValueContainer()
////        try container.encodeNil()
////    }
////}
