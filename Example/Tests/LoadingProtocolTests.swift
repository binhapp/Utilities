import XCTest
import Utilities

class LoadingProtocolTests: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UIViewController()
        viewController.view.backgroundColor = .white
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func testLoading() {
        viewController.view.showLoading()
        XCTAssertEqual(viewController.view.isLoading, true)
        
        waitForExpectations { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.viewController.view.hideLoading()
                XCTAssertEqual(self.viewController.view.isLoading, false)
                expectation.fulfill()
            }
        }
    }
    
    func testMultipleLoading() {
        viewController.view.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewController.view.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.viewController.view.hideLoading()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewController.view.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.viewController.view.hideLoading()
            }
        }
        
        waitForExpectations { (expectation) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.viewController.view.hideLoading()
                XCTAssertEqual(self.viewController.view.isLoading, false)
                expectation.fulfill()
            }
        }
    }
    
}
