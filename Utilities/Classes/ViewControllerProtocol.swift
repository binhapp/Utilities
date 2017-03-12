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

public protocol ViewControllerOpenable: Parameterable {
    
}

public prefix func ! <T: NavigationNameable> (left: T) -> UINavigationController {
    let viewController = left.navigationName.0.storyboardName & left.navigationName.1
    return viewController as! UINavigationController
}

public func + <T> (left: UINavigationController, right: T.Type) -> T {
    return left.topViewController as! T
}

public prefix func ! <T: ViewControllerInstantiateable> (left: T.Type) -> T {
    let viewController = left.storyboardName.storyboardName & left.name
    return viewController as! T
}

private func & (left: String, right: String) -> UIViewController {
    let storyboard = UIStoryboard(name: left, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: right)
    return viewController
}
