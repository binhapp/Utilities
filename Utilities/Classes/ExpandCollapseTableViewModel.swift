//
//  ExpandCollapseTableViewModel.swift
//  Pods
//
//  Created by blcsntb on 2/12/17.
//
//

import UIKit

public class ExpandCollapseTableViewModel<Parent: ParentTypeProtocol, Child: ChildTypeProtocol> {
    private(set) public var items = [CellType<Parent, Child>]()
    private var isMultipleExpand: Bool
    
    public init(isMultipleExpand: Bool = false) {
        self.isMultipleExpand = isMultipleExpand
    }
    
    public func removeAll() {
        items.removeAll()
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
                parent.get.parent.append(childIndex)
            }
        }
    }
    
    public func heightForRow(indexPath: NSIndexPath) -> CGFloat? {
        let childIndex = indexPath.row
        
        if case .Child(let child) = items[childIndex],
            let parentIndex = child.get.child.parentIndex,
            case .Parent(let parent) = items[parentIndex]
        {
            if parent.get.parent.isHidden(childIndex) {
                return 0
            }
        }
        
        return nil
    }
    
    public var expandCollapse: (NSIndexPath, (Child) -> Void) -> [NSIndexPath] {
        return isMultipleExpand ? multipleExpandCollapse : singleExpandCollapse
    }
    
    private func singleExpandCollapse(indexPath: NSIndexPath, completion: (Child) -> Void) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        
        if case .Parent(let parent) = items[indexPath.row] {
            indexPaths.appendContentsOf(collapsePrevious(indexPath, parent: parent))
        }
        
        indexPaths.appendContentsOf(multipleExpandCollapse(indexPath, completion: completion))
        return indexPaths
    }
    
    private func multipleExpandCollapse(indexPath: NSIndexPath, completion: (Child) -> Void) -> [NSIndexPath] {
        switch items[indexPath.row] {
        case .Parent(let parent):
            parent.get.parent.select()
            items[indexPath.row] = CellType.Parent(parent.get.select)
            return [indexPath]
        case .Child(let child):
            completion(child)
        }
        
        return []
    }
    
    private func collapsePrevious(indexPath: NSIndexPath, parent: Parent) -> [NSIndexPath] {
        if parent.get.parent.isExpand {
            return []
        }
        
        for index in 0..<items.count {
            if index == indexPath.row {
                continue
            }
            
            if case .Parent(let parent) = items[index] {
                if parent.get.parent.isExpand {
                    let indexPath = NSIndexPath(forRow: index, inSection: indexPath.section)
                    return multipleExpandCollapse(indexPath) { _ in }
                }
            }
        }
        
        return []
    }
}

public enum CellType<ParentType, ChildType> {
    case Parent(ParentType)
    case Child(ChildType)
}

public protocol ParentTypeProtocol {
    var get: (parent: ParentCellProtocol, identifier: String, select: Self) { get }
}

public protocol ChildTypeProtocol {
    var get: (child: ChildCellProtocol, identifier: String) { get }
}

public class ParentCell<Value>: ParentCellProtocol {
    private(set) public var value: Value
    private(set) public var isExpand = false
    private(set) public var childs = [(index: Int, isHidden: Bool)]()
    
    public init(value: Value) {
        self.value = value
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

public protocol ParentCellProtocol {
    var isExpand: Bool { get }
    var childs: [(index: Int, isHidden: Bool)] { get }
    func append(childIndex: Int)
    func select()
    func isHidden(childIndex: Int) -> Bool
}

public class ChildCell<Value>: ChildCellProtocol {
    private(set) public var parentIndex: Int?
    private(set) public var value: Value
    
    public init(parentIndex: Int?, value: Value) {
        self.parentIndex = parentIndex
        self.value = value
    }
}

public protocol ChildCellProtocol {
    var parentIndex: Int? { get }
}
