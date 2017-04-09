//
//  API.swift
//  Utilities
//
//  Created by Binh on 4/8/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIRequest {
    var url: String
    var method: Method
    var parameters: [String : Any]?
    var headers: [String : String]?
    
    enum Method {
        case get, post
    }
}

protocol APIRequestable {
    associatedtype ResponseType: APIResponseable
    func createRequest() -> APIRequest
}

protocol APIResponseable {
    init(json: JSON)
}

extension APIRequestable {
    private func httpMethod(_ method: APIRequest.Method) -> HTTPMethod {
        switch method {
        case .get: return .get
        case .post: return .post
        }
    }
    
    func request(completion: @escaping (ResponseType) -> Void) {
        let request = createRequest()
        Alamofire.request(
            request.url,
            method: httpMethod(request.method),
            parameters: request.parameters,
            headers: request.headers).validate().responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    completion(ResponseType(json: JSON(data)))
                case .failure(_):
                    break
                }
        }
    }
}
