import Foundation

@IBDesignable
open class CustomView: UIView {
    
    @IBInspectable
    public var subViewIndex: Int = 0 {
        didSet {
            guard let unwrapContent = contentView else {
                assertionFailure()
                return
            }
            unwrapContent.removeFromSuperview()
            xibSetup()
            layoutIfNeeded()
        }
    }
    
    private var contentView : UIView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        guard let viewFromNib = loadViewFromNib() else {
            assertionFailure()
            return
        }
        
        viewFromNib.frame = bounds
        viewFromNib.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        
        addSubview(viewFromNib)
        contentView = viewFromNib
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[subViewIndex] as? UIView
        return view
    }
}
