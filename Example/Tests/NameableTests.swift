import XCTest
import Utilities

class NameableTests: XCTestCase {
    func testClass() {
        XCTAssertEqual(Class1.name, "Class1")
        XCTAssertNotEqual(Class2.name, "Class2")
    }
    
    class Class1: Nameable {
        
    }
    
    class Class2: Nameable {
        static var name: String { return "" }
    }
}

extension NameableTests {
    func testViewController() {
        XCTAssertEqual(ViewController1.name, "ViewController1")
        XCTAssertNotEqual(ViewController2.name, "ViewController2")
    }
    
    class ViewController1: UIViewController, Nameable {
        
    }
    
    class ViewController2: UIViewController, Nameable {
        static var name: String { return "" }
    }
}

extension NameableTests {
    func testTableViewCell() {
        XCTAssertEqual(TableViewCell1.name, "TableViewCell1")
        XCTAssertNotEqual(TableViewCell2.name, "TableViewCell2")
    }
    
    class TableViewCell1: UITableViewCell, Nameable {
        
    }
    
    class TableViewCell2: UITableViewCell, Nameable {
        static var name: String { return "" }
    }
}

extension NameableTests {
    func testCollectionViewCell() {
        XCTAssertEqual(CollectionViewCell1.name, "CollectionViewCell1")
        XCTAssertNotEqual(CollectionViewCell2.name, "CollectionViewCell2")
    }
    
    class CollectionViewCell1: UICollectionViewCell, Nameable {
        
    }
    
    class CollectionViewCell2: UICollectionViewCell, Nameable {
        static var name: String { return "" }
    }
}
