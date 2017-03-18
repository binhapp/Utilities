import UIKit

@IBDesignable
open class CustomView: UIView {
    
    @IBInspectable
    public var indexSubView: Int = 0 {
        didSet {
            guard let unwrapContent = contentView else { return }
            unwrapContent.removeFromSuperview()
            xibSetup()
            layoutIfNeeded()
        }
    }
    
    private var contentView : UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        guard let viewFromNib = loadViewFromNib() else { return }
        contentView = viewFromNib
        contentView.frame = bounds
        contentView.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[indexSubView] as? UIView
        return view
    }
}
