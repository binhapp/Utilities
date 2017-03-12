import Foundation

public protocol APIMethodable {
    associatedtype MethodType
    func getMethod() -> MethodType
}

public protocol APIURLable {
    associatedtype URLType
    func getURL() -> URLType
}

public protocol APIParameterable {
    associatedtype ParameterType
    func getParameter() -> ParameterType
}

public protocol APIResponseable {
    associatedtype ResponseType
    init(data: ResponseType)
}

public protocol APIRequestable: APIParameterable {
    associatedtype SendType: APISenable
    associatedtype MethodType: APIMethodable
    associatedtype URLType: APIURLable
    associatedtype ResponseType: APIResponseable
    
    func request() -> (SendType.Type, MethodType, URLType)
}

public protocol APISenable {
    static func send<T1: APIMethodable, T2: APIURLable, T3: APIParameterable, T4: APIResponseable>(request: (T1, T2, T3), response: (T4) -> Void)
}

public func > <T: APIRequestable> (left: T, right: (T.ResponseType) -> Void) {
    let request = left.request()
    request.0.send(request: (request.1, request.2, left), response: right)
}
