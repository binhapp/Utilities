import UIKit

public protocol LoadingProtocol {
    func showLoading()
    func hideLoading()
}

extension UIView: LoadingProtocol {
    public class LoadingView: UIActivityIndicatorView {
        var count: Int = 0
    }
    
    private func createLoadingView() -> UIView {
        let indicatorView = LoadingView(activityIndicatorStyle: .gray)
        indicatorView.frame.size = frame.size
        indicatorView.startAnimating()
        return indicatorView
    }
    
    public func showLoading() {
        if loadingView != nil {
            loadingView?.count += 1
            return
        }
        layoutIfNeeded()
        addSubview(createLoadingView())
    }
    
    public func hideLoading() {
        loadingView?.count -= 1
        if loadingView?.count == 0 {
            loadingView?.removeFromSuperview()
        }
    }
    
    public var loadingView: LoadingView? {
        return subviews.first(where: { $0 is LoadingView }) as? LoadingView
    }
}
