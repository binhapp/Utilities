//
//  ExpandCollapseModel.swift
//  Pods
//
//  Created by blcsntb on 2/12/17.
//
//

import UIKit

public protocol ChildCellProtocol {
    var parentIndex: Int? { get set }
}

public protocol ParentCellProtocol {
    var isExpand: Bool { get set }
    var childs: [(index: Int, isHidden: Bool)] { get set }
    func append(childIndex: Int)
    func select()
    func isHidden(childIndex: Int) -> Bool
}

public protocol ChildTypeProtocol {
    var identifier: String { get }
    var cell: ChildCellProtocol { get }
}

public protocol ParentTypeProtocol {
    var identifier: String { get }
    var cell: ParentCellProtocol { get }
    var select: Self { get }
}

public class ChildCell<Value>: ChildCellProtocol {
    public var parentIndex: Int?
    public var value: Value
    
    public init(parentIndex: Int? = nil, value: Value) {
        self.parentIndex = parentIndex
        self.value = value
    }
}

public class ParentCell<Value>: ParentCellProtocol {
    public var value: Value
    public var isExpand: Bool
    public var childs = [(index: Int, isHidden: Bool)]()
    
    public init(value: Value, isExpand: Bool = false) {
        self.value = value
        self.isExpand = isExpand
    }
    
    public func append(childIndex: Int) {
        childs.append((index: childIndex, isHidden: true))
    }
    
    public func select() {
        isExpand = !isExpand
        childs = childs.map({(index: $0.index, isHidden: !$0.isHidden)})
    }
    
    public func isHidden(childIndex: Int) -> Bool {
        return childs.filter({$0.index == childIndex}).first?.isHidden ?? true
    }
}

public enum CellType<ParentType: ParentTypeProtocol, ChildType: ChildTypeProtocol> {
    case Parent(ParentType)
    case Child(ChildType)
    
    public var identifier: String {
        switch self {
        case .Parent(let parent):
            return parent.identifier
        case .Child(let child):
            return child.identifier
        }
    }
}

public class ExpandCollapseModel<Parent: ParentTypeProtocol, Child: ChildTypeProtocol> {
    public var items = [CellType<Parent, Child>]()
    
    public init() {
        
    }
    
    public func append(child: Child) {
        items.append(CellType.Child(child))
    }
    
    public func append(parent: Parent, completion: (Int) -> [Child]) {
        let parentIndex = items.count
        items.append(.Parent(parent))
        let childs = completion(parentIndex)
        
        for child in childs {
            let childIndex = items.count
            items.append(.Child(child))
            
            if case .Parent(let parent) = items[parentIndex] {
                parent.cell.append(childIndex)
            }
        }
    }
    
    public func heightForRow(indexPath: NSIndexPath) -> CGFloat? {
        let childIndex = indexPath.row
        
        if case .Child(let child) = items[childIndex],
            let parentIndex = child.cell.parentIndex,
            case .Parent(let parent) = items[parentIndex]
        {
            if parent.cell.isHidden(childIndex) {
                return 0
            }
        }
        
        return nil
    }
    
    public func singleExpandCollapse(indexPath: NSIndexPath) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        
        if case .Parent(let parent) = items[indexPath.row] {
            indexPaths.appendContentsOf(collapsePrevious(indexPath, parent: parent))
        }
        
        indexPaths.appendContentsOf(multipleExpandCollapse(indexPath))
        return indexPaths
    }
    
    public func multipleExpandCollapse(indexPath: NSIndexPath) -> [NSIndexPath] {
        if case .Parent(let parent) = items[indexPath.row] {
            parent.cell.select()
            items[indexPath.row] = CellType.Parent(parent.select)
            return [indexPath]
        }
        
        return []
    }
    
    private func collapsePrevious(indexPath: NSIndexPath, parent: Parent) -> [NSIndexPath] {
        if parent.cell.isExpand {
            return []
        }
        
        for index in 0..<items.count {
            if index == indexPath.row {
                continue
            }
            
            if case .Parent(let parent) = items[index] {
                if parent.cell.isExpand {
                    let indexPath = NSIndexPath(forRow: index, inSection: indexPath.section)
                    return multipleExpandCollapse(indexPath)
                }
            }
        }
        
        return []
    }
}
