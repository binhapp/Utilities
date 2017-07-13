import XCTest
import Utilities
@testable import Utilities_Example

class CustomViewTests: XCTestCase {
    
    func testCustomViewInitCoder() {
        let viewController = UIStoryboard(name: "Storyboard", bundle: nil)
            .instantiateInitialViewController() as! ViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        XCTAssertNotNil(viewController.myView)
    }
    
    func testCustomViewInitFrame() {
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        let myView = MyView(frame: viewController.view.frame)
        myView.subViewIndex = 1
        viewController.view.addSubview(myView)
        
        XCTAssertEqual(viewController.view.frame, myView.frame)
    }
}
