import Foundation

public protocol TableViewCellDatable: Nameable, Parameterable {}

public func &<T>(lhs: UITableView, rhs: T.Type) where T : Nameable {
    lhs & (rhs, rhs.name)
}

public func &<T>(lhs: UITableView, rhs: (T.Type, String)) where T : Nameable {
    let nib = UINib(nibName: rhs.0.name, bundle: nil)
    lhs.register(nib, forCellReuseIdentifier: rhs.1)
}

public func &<T>(lhs: (UITableView, IndexPath), rhs: T.Type) -> T where T : TableViewCellDatable {
    return (lhs.0, lhs.1) & (rhs, rhs.name)
}

public func &<T>(lhs: (UITableView, IndexPath), rhs: (T.Type, String)) -> T where T : TableViewCellDatable {
    let cell = lhs.0.dequeueReusableCell(withIdentifier: rhs.1, for: lhs.1)
    return cell as! T
}
