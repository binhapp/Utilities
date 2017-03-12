import Foundation

public protocol TableViewCellDatable: Nameable, Parameterable {
    
}

public func & <T: Nameable> (left: UITableView, right: T.Type) {
    left & (right, right.name)
}

public func & <T: Nameable> (left: UITableView, right: (T.Type, String)) {
    let nib = UINib(nibName: right.0.name, bundle: nil)
    left.register(nib, forCellReuseIdentifier: right.1)
}

public func + <T: TableViewCellDatable> (left: (UITableView, IndexPath), right: T.Type) -> T {
    return (left.0, left.1) + (right, right.name)
}

public func + <T: TableViewCellDatable> (left: (UITableView, IndexPath), right: (T.Type, String)) -> T {
    let cell = left.0.dequeueReusableCell(withIdentifier: right.1, for: left.1)
    return cell as! T
}
