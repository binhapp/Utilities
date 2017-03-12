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
    
    struct Alamofire: APISenable {
        static func send<T1 : APIMethodable, T2 : APIURLable, T3 : APIParameterable, T4 : APIResponseable>(request: (T1, T2, T3), response: (T4) -> Void) {
            let fullName = (request.0.getMethod(), request.1.getURL(), request.2.getParameter())
            response(T4(data: ["full_name": fullName]))
        }
    }
    
    struct Login: APIRequestable {
        let userName: String
        let password: String
        
        func getParameter() -> [String : Any] {
            return [
                "username": userName,
                "password": password,
            ]
        }
        
        func request() -> (Alamofire.Type, Method, URL) {
            return (Alamofire.self, .post, .login)
        }
        
        typealias ResponseType = User
        struct User: APIResponseable {
            let fullName: Any?
            
            init(data: [String : Any]) {
                fullName = data["full_name"]
            }
        }
    }
}
