//
//  RecipeMakeManager.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 25..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation
import Alamofire

struct GetSandWiches: APIRequest {
    typealias T = Sandwiches
    let api = "ingredients/sandwich"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetBreads: APIRequest {
    typealias T = Ingredients
    let api = "ingredients/bread"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetToppings: APIRequest {
    typealias T = Ingredients
    let api = "ingredients/toppings"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetCheeses: APIRequest {
    typealias T = Ingredients
    let api = "ingredients/cheese"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetToastings: APIRequest {
    typealias T = Ingredients
    let api = "ingredients/toasting"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetVegetables: APIRequest {
    typealias T = Ingredients
    let api = "ingredients/vegetables"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetSauces: APIRequest {
    typealias T = Ingredients
    let api = "ingredients/sauces"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct RecipeCreateValidation: APIRequest {
    typealias T = MessageResponse
    let api = "recipe/validation"
    var method: HTTPMethod = .post
    var parameters: Parameters
}

struct GetRecipeNameChoicesList: APIRequest {
    typealias T = RecipeNameChoicesList
    let api = "recipe/name-choices"
    var method: HTTPMethod = .get
    var parameters: Parameters
}
