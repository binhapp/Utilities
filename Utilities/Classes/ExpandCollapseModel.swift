//
//  ExpandCollapseModel.swift
//
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
    func append(_ childIndex: Int)
    func select()
    func isHidden(_ childIndex: Int) -> Bool
}

public protocol ChildTypeProtocol {
    var cell: ChildCellProtocol { get }
}

public protocol ParentTypeProtocol {
    var cell: ParentCellProtocol { get }
    var select: Self { get }
}

open class ChildCell<Value>: ChildCellProtocol {
    open var parentIndex: Int?
    open var value: Value
    
    public init(parentIndex: Int? = nil, value: Value) {
        self.parentIndex = parentIndex
        self.value = value
    }
}

open class ParentCell<Value>: ParentCellProtocol {
    open var value: Value
    open var isExpand: Bool
    open var childs = [(index: Int, isHidden: Bool)]()
    
    public init(value: Value, isExpand: Bool = false) {
        self.value = value
        self.isExpand = isExpand
    }
    
    open func append(_ childIndex: Int) {
        childs.append((index: childIndex, isHidden: true))
    }
    
    open func select() {
        isExpand = !isExpand
        childs = childs.map({(index: $0.index, isHidden: !$0.isHidden)})
    }
    
    open func isHidden(_ childIndex: Int) -> Bool {
        return childs.filter({$0.index == childIndex}).first?.isHidden ?? true
    }
}

public enum CellType<ParentType: ParentTypeProtocol, ChildType: ChildTypeProtocol> {
    case parent(ParentType)
    case child(ChildType)
}

open class ExpandCollapseModel<Parent: ParentTypeProtocol, Child: ChildTypeProtocol> {
    open var items = [CellType<Parent, Child>]()
    
    public init() {
        
    }
    
    open func append(_ child: Child) {
        items.append(CellType.child(child))
    }
    
    open func append(_ parent: Parent, completion: (Int) -> [Child]) {
        let parentIndex = items.count
        items.append(.parent(parent))
        let childs = completion(parentIndex)
        
        for child in childs {
            let childIndex = items.count
            items.append(.child(child))
            
            if case .parent(let parent) = items[parentIndex] {
                parent.cell.append(childIndex)
            }
        }
    }
    
    open func heightForRow(_ indexPath: IndexPath) -> CGFloat? {
        let childIndex = indexPath.row
        
        if case .child(let child) = items[childIndex],
            let parentIndex = child.cell.parentIndex,
            case .parent(let parent) = items[parentIndex]
        {
            if parent.cell.isHidden(childIndex) {
                return 0
            }
        }
        
        return nil
    }
    
    open func singleExpandCollapse(_ indexPath: IndexPath) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        if case .parent(let parent) = items[indexPath.row] {
            indexPaths.append(contentsOf: collapsePrevious(indexPath, parent: parent))
        }
        
        indexPaths.append(contentsOf: multipleExpandCollapse(indexPath))
        return indexPaths
    }
    
    open func multipleExpandCollapse(_ indexPath: IndexPath) -> [IndexPath] {
        if case .parent(let parent) = items[indexPath.row] {
            parent.cell.select()
            items[indexPath.row] = CellType.parent(parent.select)
            return [indexPath]
        }
        
        return []
    }
    
    fileprivate func collapsePrevious(_ indexPath: IndexPath, parent: Parent) -> [IndexPath] {
        if parent.cell.isExpand {
            return []
        }
        
        for index in 0..<items.count {
            if index == indexPath.row {
                continue
            }
            
            if case .parent(let parent) = items[index] {
                if parent.cell.isExpand {
                    let indexPath = IndexPath(row: index, section: indexPath.section)
                    return multipleExpandCollapse(indexPath)
                }
            }
        }
        
        return []
    }
}
