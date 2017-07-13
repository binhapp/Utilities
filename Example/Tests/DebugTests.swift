import XCTest
import Utilities

class DebugTests: XCTestCase {
    
    func testMethodWithoutParameter() {
        func method() {
            print("Hi")
            println("Hi")
        }
        method()
    }
    
    func testMethodWithParameter() {
        func method(param1: String, param2: Int) {
            print("Hi", param1, param2)
            println("Hi", param1, param2)
        }
        method(param1: "param1", param2: 2)
    }
    
    func testProperty() {
        var property: String {
            println()
            return "this is a property"
        }
        println(property)
    }
}
