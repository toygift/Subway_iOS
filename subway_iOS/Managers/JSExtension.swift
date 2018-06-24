//
//  JSExtension.swift
//  subway_iOS
//
//  Created by Jaeseong on 2018. 5. 27..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest {
    var api: String { get }
    var method : HTTPMethod { get set }
    var parameters : Parameters { get set }
    associatedtype T: Decodable
}
extension APIRequest {
    
    func requestAPI(completionHandler: @escaping (DataResponse<T>) -> Void) {
        let url = "\(serviceURL)/\(api)/"
        //Alamofire.request(url).responseDecodable(completionHandler: completionHandler)
        Alamofire.request(url, method: method, parameters: parameters).responseDecodable(completionHandler: completionHandler)
    }
}

// MARK: - Alamofire response handlers
extension DataRequest {
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
}


//

struct FbLogin: APIRequest {

    typealias T = LoginResponse
    let api = "user/facebook-login"
    var method: HTTPMethod = .post
    var parameters: Parameters
}
struct KaLogin: APIRequest {
    typealias T = LoginResponse
    let api = "user/kakao-login"
    var method: HTTPMethod = .post
    var parameters: Parameters
}
struct GetRanking: APIRequest {
    typealias T = Ranking
    let api = "recipe"
    var method: HTTPMethod = .get
    var parameters: Parameters
}
