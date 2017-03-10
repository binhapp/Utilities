//
//  ExpandCollapseModelProtocol.swift
//
//
//  Created by blcsntb on 3/8/17.
//
//

import UIKit

public struct Cell<T> {
    var cells: [T]
    var heights: [CGFloat]
    var parent: Int?
    var hidden: Bool
}

public protocol ExpandCollapseModelProtocol: NSObjectProtocol {
    associatedtype T
    var model: [Cell<T>] { get set }
}

public extension ExpandCollapseModelProtocol {
    func append(parent: T, child: (expand: Bool, cells: [T]?) = (true, nil)) {
        model.append(Cell(cells: [parent], heights: [UITableViewAutomaticDimension], parent: nil, hidden: false))
        
        if let cells = child.cells {
            let heights: [CGFloat] = Array(repeating: UITableViewAutomaticDimension, count: cells.count)
            let parentIndex = model.count - 1
            model.append(Cell(cells: cells, heights: heights, parent: parentIndex, hidden: child.expand))
        }
    }
    
    var numberOfSections: Int {
        return model.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if model[section].hidden { return 0 }
        return model[section].cells.count
    }
    
    func heightForRow(indexPath: NSIndexPath) -> CGFloat {
        return model[indexPath.section].heights[indexPath.row]
    }
    
    func displayCell(cell: UITableViewCell, forRowAt indexPath: NSIndexPath) {
        let height = cell.bounds.height
        model[indexPath.section].heights[indexPath.row] = height
    }
    
    func getType(indexPath: NSIndexPath) -> T {
        return model[indexPath.section].cells[indexPath.row]
    }
    
    func isExpand(indexPath: NSIndexPath) -> Bool {
        guard let indexChild = getIndexChild(indexPath: indexPath) else { return false }
        return !model[indexChild].hidden
    }
    
    func selectParent(indexPath: NSIndexPath, completion: (Int, Bool) -> Void) {
        guard let indexChild = getIndexChild(indexPath: indexPath) else { return }
        model[indexChild].hidden = !model[indexChild].hidden
        completion(indexChild, model[indexChild].hidden)
    }
    
    func getIndexChild(indexPath: NSIndexPath) -> Int? {
        guard isParent(indexPath: indexPath),
            let child = model.filter({$0.parent == indexPath.section}).first,
            let indexChild = model.index(where: {$0.parent == child.parent})
            else { return nil }
        
        return indexChild
    }
    
    func isParent(indexPath: NSIndexPath) -> Bool {
        return model[indexPath.section].parent == nil
    }
}
