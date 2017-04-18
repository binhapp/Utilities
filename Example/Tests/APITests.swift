//
//  APITests.swift
//  Utilities
//
//  Created by Binh on 4/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Utilities_Example

class APITests: XCTestCase {
    func testGithubUser() {
        let expect = expectation(description: "api github user")
        GithubUser.Request(userName: "blcsntb").send { (user) in
            expect.fulfill()
            XCTAssertEqual(user.name, "blcsntb")
        }
        wait(for: [expect], timeout: 30)
    }
}
