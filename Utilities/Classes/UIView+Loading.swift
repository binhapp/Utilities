import UIKit

extension UIView {
    private var tagOfLoadingView: Int {
        return 124
    }
    
    private func createLoadingView() -> UIView {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        layoutIfNeeded()
        indicatorView.frame.size = frame.size
        indicatorView.tag = tagOfLoadingView
        indicatorView.startAnimating()
        return indicatorView
    }
    
    private var getLoadingView: UIView? {
        return subviews.filter { $0.tag == tagOfLoadingView }.first
    }
    
    func showLoading() {
        addSubview(createLoadingView())
    }
    
    func stopLoading() {
        getLoadingView?.removeFromSuperview()
    }
}
