//
//  UIViewController+Dismiss.swift
//  Pods
//
//  Created by Binh Nguyen on 7/14/17.
//  Copyright © 2017 blcsntb. All rights reserved.
//

import UIKit

protocol DismissProtocol {
    func dismissWithFlag()
}

public extension UIViewController {
    public static func dismissToViewController<T: UIViewController>(
        animated: Bool = false,
        filter: @escaping ((UIViewController) -> Bool) = { $0 is T },
        completion: @escaping (T?) -> Void)
    {
        let topControllers = getTopControllers()
        let filterViewControllers = topControllers.filter(filter)
        
        if filterViewControllers.isEmpty {
            topControllers.first?.dismissViewController(animated: animated) {
                dismissToViewController(animated: animated, filter: filter, completion: completion)
            }
            
        } else {
            completion(filterViewControllers.first as? T)
        }
    }
    
    public static func dismissViewController(
        animated: Bool = false,
        filter: @escaping ((UIViewController) -> Bool),
        completion: @escaping (([UIViewController]) -> Void))
    {
        let topControllers = getTopControllers()
        let filterViewControllers = topControllers.filter(filter)
        
        if filterViewControllers.isEmpty {
            completion(topControllers)
            
        } else {
            topControllers.first?.dismissViewController(animated: animated) {
                dismissViewController(filter: filter, completion: completion)
            }
        }
    }
    
    private func dismissViewController(
        animated: Bool = false,
        completion: @escaping () -> Void)
    {
        if let delegate = self as? DismissProtocol {
            delegate.dismissWithFlag()
        }
        self.dismiss(animated: animated, completion: completion)
    }
    
    public static func getTopControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        guard var topController = UIApplication.shared.keyWindow?.rootViewController else {
            return viewControllers
        }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        if let navigationController = topController as? UINavigationController,
            let topViewController = navigationController.topViewController
        {
            viewControllers.append(navigationController)
            topController = topViewController
        }
        
        if let tabBarController = topController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController
        {
            viewControllers.append(tabBarController)
            topController = selectedViewController
        }
        
        viewControllers.append(topController)
        
        return viewControllers
    }
}
