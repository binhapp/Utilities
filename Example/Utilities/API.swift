//
//  API.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Utilities

extension APIParameterable {
    typealias ParameterType = [String: Any]
}

extension APIResponseable {
    typealias ResponseType = [String: Any]
}

struct API {
    enum Method: String, APIMethodable {
        case post
        
        func getMethod() -> String {
            return rawValue
        }
    }
    
    enum URL: String, APIURLable {
        case login
        
        func getURL() -> String {
            return rawValue
        }
    }
    
    struct Alamofire: APIRequestable {
        static func request<T1, T2, T3, T4>(method: T1, url: T2, parameter: T3, response: (T4) -> Void)
            where T1 : APIMethodable, T2 : APIURLable, T3 : APIParameterable, T4 : APIResponseable
        {
            let fullName = (method.getMethod(), url.getURL(), parameter.getParameter())
            response(T4(data: ["full_name": fullName]))
        }
    }
}
