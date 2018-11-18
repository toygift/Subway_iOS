//
//  TokenAuth.swift
//  PickyCookBook
//
//  Created by jaeseong on 2017. 9. 11..
//  Copyright © 2017년 jaeseong. All rights reserved.
//

import Foundation
import Security
import SwiftyJSON
import Alamofire

let serviceURL = "https://api.my-subway.com"
let serviceName = "com.teamsubway.subway-iOS"

class TokenAuth {
    // MARK: Save
    //
    //
    static let SERVER_TOKEN = "server_token"
    
    static func save(_ service: String, account: String, value: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount: account,
            kSecValueData : value.data(using: .utf8, allowLossyConversion: false)!]
        
        SecItemDelete(keyChainQuery)
        
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "토큰 값 저장에 실패")
        NSLog("status=\(status)")
    }
    // MARK: Load
    //
    //
    static func load(_ service: String, account: String) -> String? {
        
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecReturnData : kCFBooleanTrue,
            kSecMatchLimit : kSecMatchLimitOne]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if (status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("실패 \(status)")
            return nil
        }
    }
    // MARK: Delete
    //
    //
    static func delete(_ service: String, account: String) {
        let keyChainQuery : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "토큰삭제실패")
        print("status=\(status)")
    }
    
    
    
    static func getAuthHeaders() -> HTTPHeaders? {
        if let accessToken = self.load(serviceName, account: SERVER_TOKEN) {
            return ["Authorization" : "Token \(accessToken)"] as HTTPHeaders
        } else {
            return nil
        }
    }
}
