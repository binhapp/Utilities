import Foundation
import Utilities

extension API {
    struct Login: APIable {
        let userName: String
        let password: String
        
        func getParameter() -> [String : Any] {
            return [
                "username": userName,
                "password": password,
            ]
        }
        
        func api() -> (Method, URL, Alamofire.Type) {
            return (.post, .login, Alamofire.self)
        }
        
        typealias ResponseType = User
        struct User: APIResponseable {
            let fullName: Any
            
            init(data: [String : Any]) {
                fullName = data["full_name"]!
            }
        }
    }
}
