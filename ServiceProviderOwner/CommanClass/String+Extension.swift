import UIKit

extension String {
    
    static var empty: String {
        return ""
    }
    
    /** Check string is valid for email id */
    func isValidEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /** Check string is valid for mobile numbers */
    func isValidMobileNumber() -> Bool {
        let mobileNoRegEx = "[0-9]{10}"
        let mobileNoTest = NSPredicate(format: "SELF MATCHES %@", mobileNoRegEx)
        return mobileNoTest.evaluate(with: self)
    }
    
    /** Check string is empty */
    func isEmptyString() -> Bool {
        return (self.trimmingCharacters(in: CharacterSet.whitespaces) == "" || self == "") ? true: false
    }
    
    /**
     This will tell whether the string is valid or not
     - Returns: **true** if valid and **false** if not valid
     */
    func isValidString() -> Bool {
        return self == "(null)" || self == "<null>" ? false : true
    }
    
    func camelCase() -> String {
        let first = String(prefix(1)).lowercased()
        let other = String(dropFirst())
        return first + other
    }
    
    /** Check string and remove blanck spaces */
    func removeBlankSpacesFromString(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.whitespaces) != nil ? true: false
    }
    
    /** Encode string for URL */
    func encodeUrl() -> String {
        let customAllowedSet =  NSCharacterSet(charactersIn: ",-=\"#%/<>?@\\^`{|}").inverted
        let encodedUrlParamString: String = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        return encodedUrlParamString
    }
    
    var parseJSONString: Any? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let jsonData = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch { return nil }
    }
    
//    func localize() -> String {
//        return  NSLocalizedString(self, bundle: LocalizationManager.shared.bundle, comment: "")
//    }
    
    func fileName() -> String {
        let path = NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
        let components = path.components(separatedBy: "&")
        if components.count > 0 {
            return components.last!
        }
        return ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    
    var toURL: URL? {
        if let url = URL(string: self) {
            return url
        } else {
            return nil
        }
    }
    
    func addingLetterSpacing(with spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    func image(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        backgroundColor.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: size.height)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    var trim: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
  
    }

