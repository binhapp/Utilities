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
    func configure(_ value: ValueType)
}

extension TableViewCellProtocol {
    static func registerNib(_ tableView: UITableView) {
        registerNib(tableView, nibName: className, identifier: className)
    }
    
    static func registerNib(_ tableView: UITableView, nibName: String, identifier: String) {
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension TableViewCellProtocol {
    static func dequeueReusableCellWithIdentifier(_ tableView: UITableView, indexPath: IndexPath, completion: (Self) -> Void) -> Self {
        return dequeueReusableCellWithIdentifier(tableView, indexPath: indexPath, identifier: className, completion: completion)
    }
    
    static func dequeueReusableCellWithIdentifier(_ tableView: UITableView, indexPath: IndexPath, identifier: String, completion: (Self) -> Void) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Self
        completion(cell)
        return cell
    }
}
