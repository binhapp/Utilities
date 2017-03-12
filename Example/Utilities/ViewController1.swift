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
        let vc = !ViewController2.self + (title: "ViewController2", color: UIColor.blue)
        println(vc.param)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openNavigationController2() {
        let navi = !Navigation.NavigationController2
        
        let param = (title: "NavigationController2", color: UIColor.blue)
        let vc = navi + ViewController2.self + param
        println(vc.param)
        
        
        present(navi, animated: true, completion: nil)
    }
}
