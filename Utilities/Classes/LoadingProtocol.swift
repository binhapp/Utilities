import UIKit

public protocol LoadingProtocol {
    var isLoading: Bool { get }
    func showLoading()
    func hideLoading()
}

extension UIView: LoadingProtocol {
    public func showLoading() {
        if isLoading {
            loadingView?.count += 1
            return
        }
        self.addSubview(createLoadingView())
    }
    
    public func hideLoading() {
        loadingView?.count -= 1
        if loadingView?.count == 0 {
            loadingView?.removeFromSuperview()
        }
    }
    
    public var isLoading: Bool {
        return loadingView != nil
    }
    
    public var loadingView: LoadingView? {
        return self.subviews.first(where: { $0 is LoadingView }) as? LoadingView
    }
    
    private func createLoadingView() -> UIView {
        let loadingView = LoadingView(activityIndicatorStyle: .gray)
        
        self.layoutIfNeeded()
        loadingView.frame = self.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        loadingView.startAnimating()
        return loadingView
    }
    
    public class LoadingView: UIActivityIndicatorView {
        var count: Int = 1
    }
}
