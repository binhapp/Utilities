//
//  ConfigureTableViewCellProtocol.swift
//
//
//  Created by blcsnt on 2/21/17.
//
//

import UIKit

public protocol ConfigureTableViewCellProtocol: class, ClassNameProtocol {
    associatedtype ValueType
    func configure(value: ValueType)
}

public extension ConfigureTableViewCellProtocol {
    public static func registerNib(tableView: UITableView) {
        tableView.registerNib(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    public static func dequeueReusableCellWithIdentifier(tableView: UITableView, indexPath: NSIndexPath, completion: Self -> Void) -> Self {
        let cell = tableView.dequeueReusableCellWithIdentifier(className, forIndexPath: indexPath) as! Self
        completion(cell)
        return cell
    }
}
