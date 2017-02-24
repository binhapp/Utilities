//
//  StoryboardProtocol.swift
//
//
//  Created by blcsntb on 2/24/17.
//
//

import Foundation

public protocol StoryboardProtocol: BundleProtocol {
    func getStoryboardName() -> String
}

public extension StoryboardProtocol {
    public var storyboard: UIStoryboard {
        return UIStoryboard(name: getStoryboardName(), bundle: bundle)
    }
}