import UIKit

extension UIColor {
    
    class func hexStringToUIColor (hexString: String?) -> UIColor {
        
        guard let hex = hexString else {
            return UIColor.clear
        }
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.clear
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, customAlpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: customAlpha)
    }
    
    convenience init(netHex: Int, alpha: CGFloat) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff, customAlpha: alpha)
    }
    
    class func customWhiteColor() -> UIColor {
        return UIColor(netHex: 0xffffff, alpha: 1.0)
    }
    
    class func customWhiteAlphaColor() -> UIColor {
        return UIColor(netHex: 0xffffff, alpha: 0.8)
    }
    
    class func appThemeColor() -> UIColor {
        return APP_BLUE_COLOR
    }
    
  class  func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    class func appDarkColor() -> UIColor {
        return UIColor.black
    }
}

let COLOR_c4c4c4 = UIColor(netHex: 0xc4c4c4, alpha: 1)
let COLOR_3ae3e2 = UIColor(netHex: 0x3ae3e2, alpha: 1)
let COLOR_219c9b = UIColor(netHex: 0x219c9b, alpha: 1)

let COLOR_1041fb = UIColor(netHex: 0x1041fb, alpha: 1)
let COLOR_262525 = UIColor(netHex: 0x262525, alpha: 1)
let COLOR_141414 = UIColor(netHex: 0x141414, alpha: 1)
let COLOR_131313 = UIColor(netHex: 0x131313, alpha: 1)
let COLOR_61b160 = UIColor(netHex: 0x61b160, alpha: 1)
let COLOR_f48b41 = UIColor(netHex: 0xf48b41, alpha: 1)

//Scroll View Modules
let SCROLL_VIEW_BACKGROUND_COLOR = COLOR_c4c4c4
let SCROLL_VIEW_BORDER_COLOR = COLOR_3ae3e2

let LIGHT_SEPARATOR_COLOR = COLOR_219c9b
let DARK_SEPARATOR_COLOR = COLOR_219c9b

let APP_BLUE_COLOR = COLOR_1041fb
let APP_DARK_THEME_COLOR = UIColor.black

let BLACK_TWO_COLOR = COLOR_262525
let BLACK_THREE_COLOR = COLOR_141414
let BLACK_FOUR_COLOR = COLOR_131313

let GREEN_CALL_ANSWER_COLOR = COLOR_61b160
let TOAST_WARNING_COLOR = COLOR_f48b41
