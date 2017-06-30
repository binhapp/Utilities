import Foundation

public extension UITableView {
    public func register<T : Nameable>(
        cell: T.Type,
        identifier: String = T.name)
    {
        let nib = UINib(nibName: cell.name, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
}

public extension UITableView {
    public func dequeueReusable<T : Nameable>(
        cell: T.Type,
        withIdentifier identifier: String = T.name,
        for indexPath: IndexPath)
        -> T
    {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell as! T
    }
}
