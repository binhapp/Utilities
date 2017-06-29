//
//  FirstTableViewCell.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Utilities

class TableViewCell1: UITableViewCell, Nameable, Parameterable {
    @IBOutlet weak var label: UILabel!
    
    var parameter: (title: String, color: UIColor)! {
        didSet {
            label.text = parameter.title
            label.textColor = parameter.color
        }
    }
}
