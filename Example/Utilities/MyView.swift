//
//  MyView.swift
//  Utilities
//
//  Created by Binh Nguyen on 7/13/17.
//  Copyright © 2017 blcsntb. All rights reserved.
//

import UIKit
import Utilities

@IBDesignable
class MyView: UIView, CustomViewProtocol {

    @IBInspectable
    var viewIndex: Int = 0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    var label: UILabel { return viewIndex == 0 ? label1 : label2 }
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
}
