import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
}

public extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return String(describing: type(of: self))
    }
}

extension UIView: ClassNameProtocol {}
extension UIViewController: ClassNameProtocol {}
