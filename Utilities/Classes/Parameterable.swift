import Foundation

public protocol Parameterable: class {
    associatedtype ParameterType
    var parameter: ParameterType { get set }
}

public extension Parameterable {
    public func with(parameter: ParameterType) -> Self {
        self.parameter = parameter
        return self
    }
}
