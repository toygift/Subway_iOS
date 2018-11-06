//
//  RecipeMakeResponses.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 25..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation

struct Sandwiches: Codable {
    let count: Int
    let next, previous: String?
    let results: [Sandwich]
}

struct Ingredients: Codable {
    let count: Int
    let next, previous: String?
    let results: [Bread]
}

struct MessageResponse: Codable {
    let detail: String
    let pk : Int?
}

struct RecipeNameChoicesList: Codable {
    let recipe_name_choices_list: [String]
}
