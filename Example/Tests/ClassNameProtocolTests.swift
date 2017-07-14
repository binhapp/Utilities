import XCTest
import Utilities

class ClassNameProtocolTests: XCTestCase {
    
    func testClass() {
        XCTAssertEqual(Class.className, "Class")
    }
    
    func testView() {
        XCTAssertEqual(View.className, "View")
        XCTAssertEqual(UIView.className, "UIView")
        XCTAssertEqual(CustomView.className, "CustomView")
    }
    
    func testViewController() {
        XCTAssertEqual(ViewController.className, "ViewController")
        XCTAssertEqual(UIViewController.className, "UIViewController")
        XCTAssertEqual(CustomViewController.className, "CustomViewController")
    }
    
    func testTableViewCell() {
        XCTAssertEqual(TableViewCell.className, "TableViewCell")
        XCTAssertEqual(UITableViewCell.className, "UITableViewCell")
    }
    
    func testCollectionViewCell() {
        XCTAssertEqual(CollectionViewCell.className, "CollectionViewCell")
        XCTAssertEqual(UICollectionViewCell.className, "UICollectionViewCell")
    }
    
    class Class: ClassNameProtocol {}
    class View: UIView {}
    class CustomView: UIView { static var className = "CustomView" }
    class ViewController: UIViewController {}
    class CustomViewController: UIViewController { static var className = "CustomViewController" }
    class TableViewCell: UITableViewCell {}
    class CollectionViewCell: UICollectionViewCell {}
}
