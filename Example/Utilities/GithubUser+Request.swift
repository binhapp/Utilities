//
//  GithubUser+Request.swift
//  Utilities
//
//  Created by Binh on 4/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

extension GithubUser: APIResponseable {
    struct Request: APIRequestable {
        var userName: String
        
        typealias ResponseType = GithubUser
        func createRequest() -> APIRequest {
            return APIRequest(
                url: "https://api.github.com/users/\(userName)",
                method: .get,
                parameters: nil,
                headers: nil)
        }
    }
}
