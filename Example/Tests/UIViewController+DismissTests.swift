//
//  UIViewController+DismissTests.swift
//  Utilities
//
//  Created by Binh Nguyen on 7/14/17.
//  Copyright © 2017 blcsntb. All rights reserved.
//

import XCTest
import Utilities
@testable import Utilities_Example

class UIViewControllerDismissTests: XCTestCase {
    
    var rootViewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        rootViewController = ViewController.instantiate
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
    }
    
    func testCurrentViewController() {
        waitForExpectations { (expectation) in
            UIViewController.dismissToViewController(filter: { $0 == self.rootViewController }) {
                XCTAssertEqual($0, self.rootViewController)
                expectation.fulfill()
            }
        }
    }
    
    func testPresentViewController() {
        rootViewController.present(ViewController.instantiate, animated: true, completion: nil)
        
        waitForExpectations { (expectation) in
            UIViewController.dismissToViewController(filter: { $0 == self.rootViewController }) {
                XCTAssertEqual($0, self.rootViewController)
                expectation.fulfill()
            }
        }
    }
}
