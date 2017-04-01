//
//  ViewController1.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Utilities

class ViewController1: UIViewController {
    static let storyboardName: StoryboardNameable = Storyboard.Storyboard1
    
    @IBAction func openViewController2() {
        let vc = ViewController2.instantiate.with(parameter: (title: "ViewController2", color: UIColor.blue))
        println(vc.parameter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openNavigationController2() {
        let navi = UIStoryboard(name: Storyboard.Storyboard1.storyboardName, bundle: nil)
            .instantiateViewController(withIdentifier: "NavigationController2")
            as! UINavigationController
        let parameter = (title: "NavigationController2", color: UIColor.blue)
        if let vc = navi.topViewController as? ViewController2 {
            _ = vc.with(parameter: parameter)
            println(vc.parameter)
        }
        present(navi, animated: true, completion: nil)
    }
}
