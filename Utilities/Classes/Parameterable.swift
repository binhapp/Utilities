import Foundation

public protocol Parameterable {
    associatedtype ParameterType
    var parameter: ParameterType! { get set }
}

public func &<T>(lhs: T, rhs: T.ParameterType) -> T where T : Parameterable {
    var copy = lhs
    copy.parameter = rhs
    return copy
}
