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
    
    typealias T = (title: String, color: UIColor)
    var param: T! {
        didSet {
            label.text = param.title
            label.textColor = param.color
        }
    }
}
