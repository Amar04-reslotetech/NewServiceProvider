import UIKit
import AudioToolbox

var vSpinner : UIView?


extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    func dontHide()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard1))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard1() {
        view.endEditing(false)
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
        
    }
    
    func showNotification(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}


/* Note: cases should be same as Storyboard name */
enum AppStoryboards: String {
    case Main, Onboarding, Events
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
extension Dictionary {
    func mergedWith(otherDictionary: [Key: Value]) -> [Key: Value] {
        var mergedDict: [Key: Value] = [:]
        [self, otherDictionary].forEach { dict in
            for (key, value) in dict {
                mergedDict[key] = value
            }
        }
        return mergedDict
    }
}
extension UITextView {
    func resizeForHeight(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = true
    }
}

extension NSDate {
    
    func dayOfTheWeek() -> String? {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = calendar.components(.weekday, from: self as Date) as NSDateComponents
        return weekdays[components.weekday - 1]
    }
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}
extension UIStoryboard {
    
//    static var main: UIStoryboard {
//        return AppStoryboards.Main.instance
//    }
//
//    static var onBoarding: UIStoryboard {
//        return AppStoryboards.Onboarding.instance
//    }
//
//    static var events: UIStoryboard {
//        return AppStoryboards.Episode.instance
//    }
}

extension UIDevice {
    
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    
    var isIPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
    
    static var isSmallDevice: Bool {
        return UIScreen.main.nativeBounds.height <= 1136
    }
}

extension Data {
    
    func toString() -> String {
        return String(data: self, encoding: .utf8)! // the data will be converted to the string
    }
    
}


extension UILabel {
    var substituteFontName: String {
        get { return self.font.fontName }
        set {
            self.font = UIFont(name: newValue, size: self.font.pointSize)
        }
    }
    var substituteFontNameBold: String {
        get { return self.font.fontName }
        set {
            self.font = UIFont(name: newValue, size: self.font.pointSize)
        }
    }
    
    func addCharacterSpacing(with spacing: CGFloat) {
        
        if let labelText = text, labelText.count > 0 {
            
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
    }
}


extension UIButton {
    var substituteFontName: String {
        get { return self.titleLabel!.font.fontName }
        set {
            self.titleLabel?.font = UIFont(name: newValue, size: self.titleLabel!.font.pointSize)
            
        }
    }
    var substituteFontNameBold: String {
        get { return self.titleLabel!.font.fontName }
        set {
            self.titleLabel?.font = UIFont(name: newValue, size: self.titleLabel!.font.pointSize)
        }
    }
}

extension UITextField {
    
    func textTrimmed() -> String {
      if let actualText = self.text {
        return actualText.trimmingCharacters(in: .whitespaces)
      } else {
        return ""
      }
    }
    var substituteFontName: String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
    
    func restrictToTakeOnlyNumbers(maxCharInField: Int, range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        let currentString: NSString = self.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        return string == numberFiltered && newString.length <= maxCharInField
    }

}


extension UIFont {
    
//    class func appRegularFontWith(size: CGFloat) -> UIFont {
//        return  UIFont(name: AppConstants.FontName.regularFont, size: size)!
//    }
//
//    class func appBoldFontWith(size: CGFloat) -> UIFont {
//        return  UIFont(name: AppConstants.FontName.boldFont, size: size)!
//    }
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    func getFontWeight() -> UIFont.Weight {
        let face = fontDescriptor.object(forKey: .face) as! String
        switch face {
        case "Bold":
            return UIFont.Weight.bold
        default:
            return UIFont.Weight.regular
        }
    }
}
    
extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UITableView {
    
    func setAutomaticDimension(rowHeight: CGFloat) {
        self.rowHeight = UITableView.automaticDimension
        estimatedRowHeight = rowHeight
    }
    
    func setAutomaticDimension(_estimatedSectionHeaderHeight: CGFloat, sectionFooterHeight: CGFloat, rowHeight: CGFloat) {
        
        self.sectionHeaderHeight = UITableView.automaticDimension
        estimatedSectionHeaderHeight = sectionHeaderHeight
        
        self.sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = sectionFooterHeight
        
        self.rowHeight = UITableView.automaticDimension
        estimatedRowHeight = rowHeight
    }
   
    
   
    
    func scrollToLastCell(animated: Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
    
    func scrollToFirstCell(animated: Bool) {
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
    }
}

extension UICollectionView {
   
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UITableViewCell {
    static var storyboardIdentifier: String {
        return "\(self)"
    }
}

//extension UIWindow {
//    class func setRootViewController(viewController: UIViewController) {
//        guard let window = appDelegate.window else { return }
//        if let rootViewController = appDelegate.window?.rootViewController {
//            if let presentedViewcontroller = rootViewController.presentedViewController {
//                presentedViewcontroller.dismiss(animated: false, completion: nil)
//            }
//        }
//        if let nav = appDelegate.window?.rootViewController as? UINavigationController {
//            nav.viewControllers.removeAll()
//        }
//        window.rootViewController = viewController
//    }
//}

extension Int {
    func toString() -> String {
        return String(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func isEvenNumber() -> Bool {
        return  self % 2 == 0
    }
}

extension Double {
    func toString() -> String {
        return String(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float {
    func toString() -> String {
        return String(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UIDevice {
    static var deviceId: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    class func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

import AVFoundation
extension CMTime {
    
    func toFloat() -> Float {
        let seconds = Float(CMTimeGetSeconds(self))
        return seconds
    }
    
    func toTimeFormat(hour: Bool=false, minute: Bool=false, seconds: Bool=false) -> String? {
        var result: String?
        
        let time = self.toFloat().toInt()
        let hr = (time % 86400) / 3600
        let min = (time % 3600) / 60
        let sec = (time % 3600) % 60
        if hour {
            result = String(format: "%02d:%02d:%02d", hr, min, sec)
        } else if minute {
            result = String(format: "%02d:%02d", min, sec)
        } else {
            result = String(format: "%02d", sec)
        }
        
        return result
    }
}

extension TimeInterval {
    
    func toFloat() -> Float {
        return Float(self)
    }
    
    func stringFromTimeInterval(hour: Bool, minute: Bool, seconds: Bool) -> String {
        
        let ti = Int(self)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if hour {
            return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
        } else if minute {
            return String(format: "%0.2d:%0.2d", minutes, seconds)
        } else {
            return String(format: "%0.2d", seconds)
        }
    }
}

extension UINavigationController {
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        var vcs = viewControllers
        vcs[vcs.count - 1] = viewController
        setViewControllers(vcs, animated: animated)
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
}

extension UIApplication {    
    class func openUrl(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}




//struct MyConstraint {
//  static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
//    let newConstraint = NSLayoutConstraint(
//      item: constraint.firstItem,
//      attribute: constraint.firstAttribute,
//      relatedBy: constraint.relation,
//      toItem: constraint.secondItem,
//      attribute: constraint.secondAttribute,
//      multiplier: multiplier,
//      constant: constraint.constant)
//
//    newConstraint.priority = constraint.priority
//
//    NSLayoutConstraint.deactivate([constraint])
//    NSLayoutConstraint.activate([newConstraint])
//
//    return newConstraint
//  }
//    static func changeMultiplier1(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
//      let newConstraint = NSLayoutConstraint(
//        item: constraint.firstItem,
//        attribute: constraint.firstAttribute,
//        relatedBy: constraint.relation,
//        toItem: constraint.secondItem,
//        attribute: constraint.secondAttribute,
//        multiplier: multiplier,
//        constant: constraint.constant)
//
//      newConstraint.priority = constraint.priority
//
//      NSLayoutConstraint.deactivate([constraint])
//      NSLayoutConstraint.activate([newConstraint])
//
//      return newConstraint
//    }
//}


struct MyConstraint1 {
   
  static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
    let newConstraint = NSLayoutConstraint(
      item: constraint.firstItem,
      attribute: constraint.firstAttribute,
      relatedBy: constraint.relation,
      toItem: constraint.secondItem,
      attribute: constraint.secondAttribute,
      multiplier: multiplier,
      constant: constraint.constant)

    newConstraint.priority = constraint.priority

    NSLayoutConstraint.deactivate([constraint])
    NSLayoutConstraint.activate([newConstraint])

    return newConstraint
  }
    
}
extension NSLayoutConstraint {

    func setMultiplier(_ multiplier:CGFloat) -> NSLayoutConstraint {

         NSLayoutConstraint.deactivate([self])

         let newConstraint = NSLayoutConstraint(
             item: firstItem!,
             attribute: firstAttribute,
             relatedBy: relation,
             toItem: secondItem,
             attribute: secondAttribute,
             multiplier: multiplier,
             constant: constant)

         newConstraint.priority = priority
         newConstraint.shouldBeArchived = shouldBeArchived
         newConstraint.identifier = identifier

         NSLayoutConstraint.activate([newConstraint])
         return newConstraint
     }

}

extension NSLayoutConstraint {

    static func setMultiplier1(_ multiplier: CGFloat, of constraint: inout NSLayoutConstraint) {
        NSLayoutConstraint.deactivate([constraint])

        let newConstraint = NSLayoutConstraint(item: constraint.firstItem, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: multiplier, constant: constraint.constant)

        newConstraint.priority = constraint.priority
        newConstraint.shouldBeArchived = constraint.shouldBeArchived
        newConstraint.identifier = constraint.identifier

        NSLayoutConstraint.activate([newConstraint])
        constraint = newConstraint
    }

}


