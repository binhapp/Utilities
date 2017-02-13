//
//  FirstViewController.swift
//  DemoMenu
//
//  Created by Binh on 2/11/17.
//  Copyright © 2017 blcsntb. All rights reserved.
//

import UIKit
import Utilities

enum ParentType: ParentTypeProtocol {
    case Expand(ParentCell<String>)
    case Collapse(ParentCell<String>)
    
    var get: (parent: ParentCellProtocol, identifier: String, select: ParentType) {
        switch self {
        case .Expand(let parent):
            return (
                parent: parent,
                identifier: "Expand Cell",
                select: .Collapse(parent)
            )
        case .Collapse(let parent):
            return (
                parent: parent,
                identifier: "Collapse Cell",
                select: .Expand(parent)
            )
        }
    }
}

enum ChildType: ChildTypeProtocol {
    case One(ChildCell<String>)
    case Two(ChildCell<String>)
    
    var get: (child: ChildCellProtocol, identifier: String) {
        switch self {
        case .One(let child):
            return (
                child: child,
                identifier: "Item 1 Cell"
            )
        case .Two(let child):
            return (
                child: child,
                identifier: "Item 2 Cell"
            )
        }
    }
}

class ExpandCollapseTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let model = ExpandCollapseTableViewModel<ParentType, ChildType>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadData()
    }
    
    private func reloadData() {
        model.removeAll()
        model.append(.One(ChildCell(parentIndex: nil, value: "Parent")))
        model.append(.Collapse(ParentCell(value: "0"))) { (parentIndex) -> [ChildType] in
            return [.One(ChildCell(parentIndex: parentIndex, value: "1"))]}
        model.append(.Collapse(ParentCell(value: "2"))) { (parentIndex) -> [ChildType] in
            return [.Two(ChildCell(parentIndex: parentIndex, value: "3"))]}
        model.append(.Collapse(ParentCell(value: "4"))) { (parentIndex) -> [ChildType] in
            return [.One(ChildCell(parentIndex: parentIndex, value: "5")),
                    .Two(ChildCell(parentIndex: parentIndex, value: "6")),
                    .One(ChildCell(parentIndex: parentIndex, value: "7")),
                    .Two(ChildCell(parentIndex: parentIndex, value: "8")),
                    .One(ChildCell(parentIndex: parentIndex, value: "9")),
                    .Two(ChildCell(parentIndex: parentIndex, value: "10")),
                    .One(ChildCell(parentIndex: parentIndex, value: "11")),
                    .Two(ChildCell(parentIndex: parentIndex, value: "12"))]}
    }
}

extension ExpandCollapseTableViewController: UITableViewDataSource, UITableViewDelegate {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        func cell<Type>(identifier: String, completion: (Type) -> Void) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
            
            if let cellType = cell as? Type {
                completion(cellType)
            }
            
            return cell
        }
        
        switch model.items[indexPath.row] {
        case .Parent(let type):
            switch type {
            case .Expand(let parent):
                return cell("Expand Cell") { (cell: ExpandTableViewCell) in
                    cell.render(parent.value)
                }
            case .Collapse(let parent):
                return cell("Collapse Cell") { (cell: CollapseTableViewCell) in
                    cell.render(parent.value)
                }
            }
        case .Child(let type):
            switch type {
            case .One:
                return cell("Item 1 Cell") { (cell: UITableViewCell) in
                    
                }
            case .Two:
                return cell("Item 2 Cell") { (cell: UITableViewCell) in
                    
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return model.heightForRow(indexPath) ?? UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPaths = model.expandCollapse(indexPath) { (type) in
            switch type {
            case .One(let child):
                print("select one \(child.value)")
            case .Two(let child):
                print("select two \(child.value)")
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
}

protocol TableViewCellProtocol {
    var label: UILabel! { get }
}

extension TableViewCellProtocol {
    func render(value: String) {
        label.text = value
    }
}

class ExpandTableViewCell: UITableViewCell, TableViewCellProtocol {
    @IBOutlet weak var label: UILabel!
}

class CollapseTableViewCell: UITableViewCell, TableViewCellProtocol {
    @IBOutlet weak var label: UILabel!
}
