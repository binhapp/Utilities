import XCTest
import Utilities
@testable import Utilities_Example

class CustomViewTests: XCTestCase {
    
    func testCustomViewInitCoder() {
        let viewController = ViewController.instantiate
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        XCTAssertNotNil(viewController.myView)
    }
    
    func testCustomViewInitFrame() {
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        let myView = MyView(frame: viewController.view.frame)
        myView.viewIndex = 1
        viewController.view.addSubview(myView)
        
        XCTAssertEqual(viewController.view.frame, myView.frame)
    }
}
