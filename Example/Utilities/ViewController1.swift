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
    @IBAction func openViewController2() {
        let vc = !ViewController2.self + (title: "ViewController2", color: UIColor.red)
        navigationController?.pushViewController(vc, animated: true)
    }
}
