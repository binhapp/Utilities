import UIKit

public protocol StoryboardNameable {
    var storyboardName: String { get }
}

public protocol NavigationNameable {
    var navigationName: (StoryboardNameable, String) { get }
}

public protocol ViewControllerInstantiateable: Nameable {
    static var storyboardName: StoryboardNameable { get }
}

public protocol ViewControllerOpenable: Parameterable {}

public prefix func !(rhs: NavigationNameable) -> UINavigationController {
    let viewController = rhs.navigationName.0.storyboardName & rhs.navigationName.1
    return viewController as! UINavigationController
}

public func &<T>(lhs: UINavigationController, rhs: T.Type) -> T {
    return lhs.topViewController as! T
}

public prefix func !<T>(rhs: T.Type) -> T where T : ViewControllerInstantiateable {
    let viewController = rhs.storyboardName.storyboardName & rhs.name
    return viewController as! T
}

private func &(lhs: String, rhs: String) -> UIViewController {
    let storyboard = UIStoryboard(name: lhs, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: rhs)
    return viewController
}
