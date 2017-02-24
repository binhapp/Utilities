//
//  ViewControllerProtocol.swift
//
//
//  Created by blcsntb on 2/24/17.
//
//

import Foundation

public protocol ViewControllerProtocol: ClassProtocol {
    static func getStoryboard() -> StoryboardProtocol
}

public extension ViewControllerProtocol {
    public static var instantiate: Self {
        let storyboard = getStoryboard().storyboard
        let identifier = className
        let viewController = storyboard.instantiateViewControllerWithIdentifier(identifier)
        return viewController as! Self
    }
}