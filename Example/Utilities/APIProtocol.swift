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

protocol APIRequestable {
    associatedtype ResponseType: APIResponseable
    func createRequest() -> APIRequest
}

protocol APIResponseable {
    init(json: JSON)
}

struct APIRequest {
    let url: String
    let method: HTTPMethod
    let parameters: [String : Any]?
    let headers: [String : String]?
}

extension APIRequestable {
    func send(completion: @escaping (ResponseType) -> Void) {
        let request = createRequest()
        Alamofire.request(
            request.url,
            method: request.method,
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
