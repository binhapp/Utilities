//
//  ViewController2.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Utilities

class ViewController2: UIViewController, ViewControllerInstantiateable, ViewControllerOpenable {
    static var storyboardName: StoryboardNameable = Storyboard.Storyboard1
    
    typealias T = (title: String, color: UIColor)
    var param: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = param.title
        navigationController?.view.tintColor = param.color
    }
}
