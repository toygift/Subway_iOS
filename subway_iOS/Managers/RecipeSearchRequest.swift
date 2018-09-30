//
//  RecipeSearchRequest.swift
//  subway_iOS
//
//  Created by jaeseong on 2018. 8. 26..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation
import Alamofire

struct GetSearchResult: APIRequest {
//    typealias T = SearchResult
    typealias T = Rankings
    var api = ""
    var method: HTTPMethod = .get
    var parameters: Parameters
}
