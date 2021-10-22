import UIKit
//import KYDrawerController
extension UINavigationBar {
    
    func transparentNavigationBar(translucent: Bool, backgroundColor: UIColor) {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = translucent
        self.backgroundColor = backgroundColor
    }
}

extension UINavigationController {
    
    func openDrawer() {
//        let drawer = parent as? KYDrawerController
//        drawer?.setDrawerState(.opened, animated: true)
    }
}
