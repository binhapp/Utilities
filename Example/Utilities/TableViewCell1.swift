//
//  FirstTableViewCell.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Utilities

class TableViewCell1: UITableViewCell, TableViewCellDatable {
    @IBOutlet weak var label: UILabel!
    
    typealias ParameterType = (title: String, color: UIColor)
    var parameter: ParameterType! {
        didSet {
            label.text = parameter.title
            label.textColor = parameter.color
        }
    }
}
