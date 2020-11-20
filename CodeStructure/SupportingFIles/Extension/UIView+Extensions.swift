import UIKit
import Foundation

// MARK: - Designable Extension
enum GradientSide {
    case TopToBottom
    case BottomToTop
    case LeftToRight
    case RightToLeft
}


extension UIView {
    
    @IBDesignable
    public class Gradient: UIView {
        @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
        @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
        @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
        @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
        @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
        @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

        override public class var layerClass: AnyClass { CAGradientLayer.self }

        var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

        func updatePoints() {
            if horizontalMode {
                gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
                gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
            }
        }
        func updateLocations() {
            gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        }
        func updateColors() {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
        override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            updatePoints()
            updateLocations()
            updateColors()
        }
    }
    
    func addShadowView() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    func addShadowView2() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 0.8
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    }
    
    func setGradientofUIView(color : UIColor) {
        //code for only bottom shadow
        let buttonHeight = self.frame.height
        let buttonWidth = self.frame.width
        
        let shadowSize: CGFloat = 15
        let contactRect = CGRect(x: -shadowSize, y: buttonHeight - (shadowSize * 0.2), width: buttonWidth + shadowSize * 2, height: shadowSize)
        self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.4
    }
    
    func roundCornersofView(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            var masked = CACornerMask()
            if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
            if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
            if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
            if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
            self.layer.maskedCorners = masked
        }
        else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func setGradientBackground(_ colors:[CGColor],_ gradientSide:GradientSide = GradientSide.TopToBottom) {
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = colors
            var startPoint:CGPoint!
            var endPoint:CGPoint!
            switch(gradientSide) {
            case .LeftToRight:
                startPoint = CGPoint(x: 0.0, y: 1.0)
                endPoint = CGPoint(x: 1.0, y: 1.0)
            case .RightToLeft:
                startPoint = CGPoint(x: 1.0, y: 1.0)
                endPoint = CGPoint(x: 0.0, y: 1.0)
            case .TopToBottom:
                startPoint = CGPoint(x: 1.0, y: 0.0)
                endPoint = CGPoint(x: 1.0, y: 1.0)
            case .BottomToTop:
                startPoint = CGPoint(x: 1.0, y: 1.0)
                endPoint = CGPoint(x: 1.0, y: 0.0)
            }
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
        
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
//            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOffset = CGSize.zero
            layer.shadowOpacity = 0.6
            layer.shadowRadius = shadowRadius
        }
    }
    
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    /// https://stackoverflow.com/a/45297466/5321670
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
