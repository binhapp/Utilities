//
//  ViewController2.swift
//  Utilities
//
//  Created by blcsntb on 3/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Utilities

class ViewController2: UIViewController, ViewControllerInstantiateable, Parameterable {
    static var storyboardName: StoryboardNameable = Storyboard.Storyboard1
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cell: TableViewCell1.self)
            tableView.register(cell: TableViewCell1.self, identifier: "custom identifier")
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var parameter: (title: String, color: UIColor)! {
        didSet {
            model = Array(repeating: parameter, count: 10)
        }
    }
    
    fileprivate var model = [ParameterType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = parameter.title
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parameter = model[indexPath.row]
        if indexPath.row == 0 {
            return tableView.dequeueReusable(cell: TableViewCell1.self, for: indexPath)
                .with(parameter: parameter)
        }
        return tableView.dequeueReusable(cell: TableViewCell1.self, withIdentifier: "custom identifier", for: indexPath)
            .with(parameter: parameter)
    }
}
