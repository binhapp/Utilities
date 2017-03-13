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

public protocol APIRequestable {
    static func request<T1, T2, T3, T4>(method: T1, url: T2, parameter: T3, response: (T4) -> Void)
    where T1: APIMethodable, T2: APIURLable, T3: APIParameterable, T4: APIResponseable
}

public protocol APIable: APIParameterable {
    associatedtype MethodType: APIMethodable
    associatedtype URLType: APIURLable
    associatedtype RequestType: APIRequestable
    associatedtype ResponseType: APIResponseable
    func api() -> (MethodType, URLType, RequestType.Type)
}

public func &<T>(lhs: T, rhs: (T.ResponseType) -> Void) where T : APIable {
    let api = lhs.api()
    api.2.request(method: api.0, url: api.1, parameter: lhs, response: rhs)
}
