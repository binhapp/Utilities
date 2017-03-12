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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView & TableViewCell1.self
            tableView & (TableViewCell1.self, "custom identifier")
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    typealias T = (title: String, color: UIColor)
    var param: T! {
        didSet {
            model = Array(repeating: param, count: 10)
        }
    }
    
    fileprivate var model = [T]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = param.title
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView, indexPath) + TableViewCell1.self
            return cell + model[indexPath.row]
        }
        
        let cell = (tableView, indexPath) + (TableViewCell1.self, "custom identifier")
        return cell + model[indexPath.row]
    }
}
