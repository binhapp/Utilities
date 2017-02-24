//
//  TableViewCellProtocol.swift
//
//
//  Created by blcsntb on 2/21/17.
//
//

import UIKit

protocol TableViewCellProtocol: class, ClassProtocol {
    associatedtype ValueType
    func configure(value: ValueType)
}

extension TableViewCellProtocol {
    static func registerNib(tableView: UITableView) {
        registerNib(tableView, nibName: className, identifier: className)
    }
    
    static func registerNib(tableView: UITableView, nibName: String, identifier: String) {
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension TableViewCellProtocol {
    static func dequeueReusableCellWithIdentifier(tableView: UITableView, indexPath: NSIndexPath, completion: Self -> Void) -> Self {
        return dequeueReusableCellWithIdentifier(tableView, indexPath: indexPath, identifier: className, completion: completion)
    }
    
    static func dequeueReusableCellWithIdentifier(tableView: UITableView, indexPath: NSIndexPath, identifier: String, completion: Self -> Void) -> Self {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! Self
        completion(cell)
        return cell
    }
}
