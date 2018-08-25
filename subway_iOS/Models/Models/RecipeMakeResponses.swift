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
