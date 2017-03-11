import XCTest
import Utilities

class NameableTests: XCTestCase {
    func testClass() {
        class Class1: Nameable {}
        XCTAssertEqual(Class1.name, "Class1")
        
        class Class2: Nameable {
            static var name: String { return "NameClass2" }
        }
        XCTAssertEqual(Class2.name, "NameClass2")
    }
}
