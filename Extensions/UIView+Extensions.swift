import UIKit

extension UIView {
    private class func viewInNibNamed<T: UIView>(_ nibNamed: String) -> T {
        return Bundle.main.loadNibNamed(nibNamed, owner: nil, options: nil)!.first as! T
    }
    
    class func nib() -> Self {
        return viewInNibNamed(nameOfClass)
    }
    
    class func nib(_ frame: CGRect) -> Self {
        let view = nib()
        view.frame = frame
        view.layoutIfNeeded()
        return view
    }
    
    func rounded(withRadius radius: Double) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
    func circle() {
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
        
    /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}
