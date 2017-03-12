//
//  AppConstant.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Utilities

enum Storyboard: String, StoryboardNameable {
    case Storyboard1
    
    var storyboardName: String {
        return rawValue
    }
}

enum Navigation: String, NavigationNameable {
    case NavigationController2
    
    var navigationName: (StoryboardNameable, String) {
        return (Storyboard.Storyboard1, rawValue)
    }
}
