//
//  File.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 8. 26..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
    let count: Int
    let next, previous: String?
    let results: [Sandwich]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}
