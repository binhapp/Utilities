import UIKit

public protocol InstantiateProtocol {
    static var storyboardName: String { get }
}

public extension InstantiateProtocol where Self: UIViewController {
    public static var instantiate: Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: className)
        return viewController as! Self
    }
}
