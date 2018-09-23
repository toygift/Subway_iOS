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
    typealias T = Breads
    let api = "ingredients/bread"
    var method: HTTPMethod = .get
    var parameters: Parameters
}

struct GetToppings: APIRequest {
    typealias T = Toppings
    let api = "ingredients/toppings"
    var method: HTTPMethod = .get
    var parameters: Parameters
}
