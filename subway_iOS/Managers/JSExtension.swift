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
        print("ff",url)
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
    typealias T = Rankings
    let api = "recipe"
    var method: HTTPMethod = .get
    var parameters: Parameters
}






// MARK: - UIView
extension UIView {
    
    @IBInspectable var shadowColor: UIColor? {
        get{
            return UIColor(cgColor: layer.shadowColor!)
        }
        set{
            layer.shadowColor = newValue?.cgColor
            //            layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    @IBInspectable var shadowOffSetX: CGFloat {
        get {
            return layer.shadowOffset.width
        }
        set{
            layer.shadowOffset = CGSize(width: newValue, height: layer.shadowOffset.height)
        }
    }
    
    @IBInspectable var shadowOffSetY: CGFloat {
        get {
            return layer.shadowOffset.height
        }
        set{
            layer.shadowOffset = CGSize(width: layer.shadowOffset.width, height: newValue)
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            layer.masksToBounds = !(layer.shadowRadius > 0)
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor//UIColor(cgColor: layer.borderColor!)
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    
    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }
}
