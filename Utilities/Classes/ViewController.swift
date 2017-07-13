import UIKit

public protocol StoryboardNameable {
    var storyboardName: String { get }
}

fileprivate extension StoryboardNameable {
    fileprivate var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

public protocol ViewControllerInstantiateable: ClassNameProtocol {
    static var storyboardName: StoryboardNameable { get }
}

public extension ViewControllerInstantiateable {
    public static var instantiate: Self {
        let storyboard = storyboardName.storyboard
        let viewController = storyboard.instantiateViewController(withIdentifier: className)
        return viewController as! Self
    }
}
