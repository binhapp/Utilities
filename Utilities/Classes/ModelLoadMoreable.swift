import Foundation

public enum LoadMoreStatus {
    case noLoad
    case loading
    case lastPage
}

public protocol LoadMoreable: class {
    var loadMoreStatus: LoadMoreStatus { get set }
    var currentPage: Int { get set }
    func fetch(page: Int, completion: @escaping () -> Void)
}

public extension LoadMoreable {
    public func loadMore(completion: @escaping () -> Void) {
        beginLoading {
            currentPage += 1
            fetch(page: currentPage, completion: completion)
        }
    }
    
    public func beginLoading(completion: () -> Void) {
        if loadMoreStatus == .noLoad {
            loadMoreStatus = .loading
            completion()
        }
    }
    
    public func endLoading(checkLastPage: () -> Bool) {
        if checkLastPage() {
            loadMoreStatus = .lastPage
        } else {
            loadMoreStatus = .noLoad
        }
    }
}
