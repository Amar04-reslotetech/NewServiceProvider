import Foundation

import UIKit

extension UIView {
    /**
     This will give the x coordinate of the view
     
     - Returns: The x Coordinate
     */
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /**
     This will give the y coordinate of the view
     
     - Returns: The y Coordinate
     */
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    /**
     This will give the width of the view
     
     - Returns: The width
     */
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    /**
     This will give the height of the view
     
     - Returns: The height
     */
    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    /**
     This will set the height of the view
     
     - Parameter width: The width of the view to be modified into
     */
    func setHeight(_ height: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
    
    /**
     This will set the width of the view
     
     - Parameter width: The width of the view to be modified into
     */
    func setWidth(_ width: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
    }
    
    /**
     This will set the x coordinate of the view
     
     - Parameter width: The x coordinate of the view to be modified into
     */
    func setX(_ x: CGFloat) {
        
        self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    /**
     This will set the y coordinate of the view
     
     - Parameter width: The x coordinate of the view to be modified into
     */
    func setY(_ y: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    /// Function adds shadow to all sides of the View
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: CGFloat(-1), height: CGFloat(1))
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
    }
    
    /// Function adds shadow to right and bottom side of the View
    func addShadowToRightAndBottom() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: CGFloat(10), height: CGFloat(10))
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
    }
    
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
    
    func setBackgroundImage(image: UIImage) {
        backgroundColor = UIColor(patternImage: image)
    }
    
    func shouldHighlight(shouldHighlight: Bool, withColor highlightedColor: UIColor = UIColor.white) {
        self.layer.borderColor = shouldHighlight ? highlightedColor.cgColor : UIColor.clear.cgColor
    }
}
