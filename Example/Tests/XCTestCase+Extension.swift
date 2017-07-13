import XCTest

extension XCTestCase {
    func waitForExpectations(
        timeout: TimeInterval = 100,
        expectationDescription: String = #file + #function,
        completion: (XCTestExpectation) -> Void)
    {
        completion(expectation(description: expectationDescription))
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
