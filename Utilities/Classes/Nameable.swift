import Foundation

public protocol Nameable {
    static var name: String { get }
}

public extension Nameable {
    static var name: String {
        return String(describing: self)
    }
}
