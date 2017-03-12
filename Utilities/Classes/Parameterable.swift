import Foundation

public protocol Parameterable {
    associatedtype T
    var param: T! { get set }
}

public func + <T: Parameterable> (left: T, right: T.T) -> T {
    var copyLeft = left
    copyLeft.param = right
    return copyLeft
}
