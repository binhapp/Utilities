import UIKit

public protocol StoryboardNameable {
    var storyboardName: String { get }
}

public protocol ViewControllerInstantiateable: Nameable {
    static var storyboardName: StoryboardNameable { get }
}

public protocol ViewControllerOpenable {
    associatedtype T
    var param: T! { get set }
}

public prefix func ! <T: ViewControllerInstantiateable> (left: T.Type) -> T {
    let storyboard = UIStoryboard(name: left.storyboardName.storyboardName, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: left.name)
    return viewController as! T
}

public func + <T: ViewControllerOpenable> (left: T, right: T.T) -> T {
    var copyLeft = left
    copyLeft.param = right
    return copyLeft
}
