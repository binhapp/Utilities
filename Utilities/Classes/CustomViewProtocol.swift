import UIKit

public protocol CustomViewProtocol {
    var viewIndex: Int { get set }
}

extension CustomViewProtocol where Self: UIView {
    public func setup() {
        self.subviews.last?.removeFromSuperview()
        self.addSubview(nibView)
    }
    
    private var nibView: UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        let nibView = views[viewIndex] as! UIView
        
        self.layoutIfNeeded()
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return nibView
    }
}
