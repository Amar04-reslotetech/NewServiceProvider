import Foundation
import UIKit
import Alamofire
import CoreLocation
import ContactsUI
//import SKCountryPicker

/// This is a common app class which contains all the common methods(i.e use one or more times with same functionality).

typealias CompletionWithSelction  = (_ index: Int) -> ()
typealias DownloadFile = ((_ url: URL?, _ message: String?) -> (Void))

class AppCommon {
    
    //MARK:- Navigation
    
    static func pushToNext(_ sourceVC: UIViewController, identifier: String)
    {
        let destinationVC =  sourceVC.storyboard?.instantiateViewController(withIdentifier: identifier)
        sourceVC.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    static func presentVC(_ sourceVC: UIViewController, identifier: String)
    {
        let destinationVC =  sourceVC.storyboard?.instantiateViewController(withIdentifier: identifier)
        sourceVC.present(destinationVC!, animated: true, completion: nil)
    }
    
    /**
     This function is made to handle print command according to your use. if isPrintEnable is true all logs will enable in your app and if it's false all logs will disable in your app.
     */
    
    static func PrintLogs(printStatement: Any){
        if Configurator.consolePrintingEnabled {
            print(printStatement)
        }
    }
    
    static func saveImageDocumentDirectory(image:UIImage){
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("profileImage.jpg")
        print(paths)
        let imageData = image.jpegData(compressionQuality: 0.75)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    static func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func getProfileImage() -> UIImage? {
        
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("profileImage.jpg")
        if fileManager.fileExists(atPath: imagePAth){
            return UIImage(contentsOfFile: imagePAth)
        }else{
            return nil
        }
    }
//    
//    static func getAddressFrom(_ coordinates : CLLocationCoordinate2D, completion: @escaping (_ addess: String) -> ())  {
//        
//        let options = ReverseGeocodeOptions(coordinate: coordinates)
//        // Or perhaps: ReverseGeocodeOptions(location: locationManager.location)
//        let geocoder = Geocoder.shared
//        _ = geocoder.geocode(options) { (placemarks, attribution, error) in
//            var addressString : String = ""
//            if let placemark = placemarks?.first {
//                
//                if placemark.qualifiedName != nil {
//                    addressString = addressString + placemark.qualifiedName!
//                    //+ ", "
//                }
//            }
//            DispatchQueue.main.async {
//                completion(addressString)
//            }
//        }
//    }
//    
    
//    static func getNearAddressFrom(_ coordinates : CLLocationCoordinate2D, and search: String, completion: @escaping (_ addess: [GeocodedPlacemark]?) -> ())  {
//
//
//        let options = ForwardGeocodeOptions(query: search)
//
//        // To refine the search, you can set various properties on the options object.
//        #if DEBUG
//        options.allowedISOCountryCodes = ["IN"]
//        #else
//        let country = CountryManager.shared.currentCountry
//        options.allowedISOCountryCodes = [country?.countryCode ?? ""]
//        #endif
//
//        options.focalLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
//        options.allowedScopes = [.all]
//
//        let geocoder = Geocoder.shared
//        _ = geocoder.geocode(options) { (placemarks, attribution, error) in
//
//            if let placemark = placemarks {
//                DispatchQueue.main.async {
//                    completion(placemark)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            }
//
//        }
//    }
//
    
    static func getVisibleController(_ rootViewController: UIViewController?) -> UIViewController? {

           var rootVC = rootViewController
           if rootVC == nil {
               rootVC = UIApplication.shared.keyWindow?.rootViewController
           }

           if rootVC?.presentedViewController == nil {
               return rootVC
           }

           if let presented = rootVC?.presentedViewController {
               if presented.isKind(of: UINavigationController.self) {
                   let navigationController = presented as! UINavigationController
                   return navigationController.viewControllers.last!
               }

               if presented.isKind(of: UITabBarController.self) {
                   let tabBarController = presented as! UITabBarController
                   return tabBarController.selectedViewController!
               }

               return getVisibleController(presented)
           }
           return nil
       }
    
//    static func getUnitId() -> String {
//        var unitId = "1"
//        if let unit = UserDefaultFunctions.valueFor(key: UserDefaultKeys.UnitId) as? String {
//            unitId = unit
//        }
//        return unitId
//    }
    
//    static func getUserId() -> String {
//        var userId = "1"
//        if let usrId = UserDefaultFunctions.valueFor(key: UserDefaultKeys.UserId) as? String {
//            userId = usrId
//        }
//        return userId
//    }
    
//    static func getContactList() -> [[String:Any]] {
//
//        let contacts = PhoneContacts.getContacts() // here calling the getContacts methods
//        var arrPhoneNumbers = [[String:Any]]()
//        for contact in contacts {
//            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
//
//                if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
//                 //   let strCC = fulMobNumVar.value(forKey: "countryCode") as? String ?? "" // get country code
//                    let name = contact.givenName + " " + contact.familyName
//                    let number = (fulMobNumVar.value(forKey: "digits") as? String ?? "")
//                    let dict = ["Name": name, "Number": number]
//                    arrPhoneNumbers.append(dict)
//                }
//            }
//        }
//        return arrPhoneNumbers // here array has all contact numbers.
//    }
//
    //MARK: -- App Route --
    
    static func rootToDrawer(_ withId: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var mainViewController = UIViewController()
        if withId == "WalletViewController" {
           let wStrbrd = AppStoryboard.wallet.instance
           mainViewController = wStrbrd.instantiateViewController(withIdentifier: withId)
        } else {
            mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        }
        
//        let leftViewController = storyboard.instantiateViewController(withIdentifier: "DrawerVC") as! DrawerVC
        
//        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//        //  nvc.isNavigationBarHidden = true
//
//        let nvcLeft: UINavigationController = UINavigationController(rootViewController: leftViewController)
//        nvcLeft.isNavigationBarHidden = true
//
////        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: nvcLeft)
//      //  slideMenuController.automaticallyAdjustsScrollViewInsets = true
//        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
////        kAppDelegateObj.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
//        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
    }

//    static func rootWithOutDrawer() {
//        if let id = UserDefaults.standard.value(forKey: "USERID") as? String {
//            let data = KeychainHelper.stringToNSDATA(string: id)
//            let status = KeychainHelper.remove(key: keyChainUserId, data: data as Data)
//            print("Keychain Delete status -- \(status)")
//        }
//
//
//        UserDefaults.standard.set(false, forKey: "loginDone")
//        UserDefaults.standard.synchronize()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "WalkThroughVC")
//
//        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//        nvc.isNavigationBarHidden = true
//
//        kAppDelegateObj.window?.rootViewController = nvc
//        kAppDelegateObj.window?.makeKeyAndVisible()
//    }
//
    
    static func rootToVC(_ withId: String, storybord: AppStoryboard) {
        let strbrd = storybord.instance
//        let vc = strbrd.instantiateViewController(withIdentifier: withId)
//        let nvc: UINavigationController = UINavigationController(rootViewController: vc)
//        nvc.isNavigationBarHidden = true
//        kAppDelegateObj.window?.rootViewController = nvc
//        kAppDelegateObj.window?.makeKeyAndVisible()
    }
    
    static func convertDateFormat(_ fromDate: String, toDate: String, date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDate
        
        if let dateN = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = toDate
            return  dateFormatter.string(from: dateN)
        } else {
            dateFormatter.dateFormat = toDate
            return  dateFormatter.string(from: Date())
        }
    }
    
//    static func changeToAppDate(_ fromDF: DateFormats, date: String) -> String {
//        
//        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = fromDF.rawValue
//        if let dateN = dateFormat.date(from: date) {
//            let oneDaysAgo = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())
//            if (dateN.hasSame(.day, as: Date())) {
//                dateFormat.dateFormat = DateFormats.format9.rawValue
//                return "Today " + dateFormat.string(from: dateN)
//            } else if (dateN.hasSame(.day, as: oneDaysAgo!)) {
//                dateFormat.dateFormat = DateFormats.format9.rawValue
//                return "Yesterday " +  dateFormat.string(from: dateN)
//            } else {
//                dateFormat.dateFormat = DateFormats.format5.rawValue
//                return dateFormat.string(from: dateN)
//            }
//        } else {
//            dateFormat.dateFormat = DateFormats.format5.rawValue
//            return  dateFormat.string(from: Date())
//        }
//    }
    
    
    static func downloadUrlToDirectory(_ strUrl : String, urlResponse: @escaping (DownloadFile)) {
        
        let url = URL(fileURLWithPath: strUrl)
        let fileName = String((url.lastPathComponent)) as NSString
        //path extension will consist of the type of file it is, m4a or mp4
        //        let pathExtension = fileName.pathExtension
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // the name of the file here I kept is yourFileName with appended extension
            documentsURL.appendPathComponent(fileName as String)
            return (documentsURL, [.removePreviousFile])
        }
        
        //        let downloadUrl: String = URL.
        let downloadUrl = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        ManageHudder.sharedInstance.startActivityIndicator()

        Alamofire.download(downloadUrl!, to: destination).response { response in
            ManageHudder.sharedInstance.stopActivityIndicator()
            if response.destinationURL != nil {
               // print(response.destinationURL!)
                urlResponse(response.destinationURL!, nil)
            } else {
                urlResponse(nil, "")
                AlertFunctions.showAlert(message: (response.error?.localizedDescription)!)
            }
        }
    }
    
    
    static func checkLocationPermission() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            print("Location Services Enabled")
            
            if CLLocationManager.authorizationStatus() == .denied {
                AlertFunctions.showAlert(message: "App Location Permission Denied. To re-enable, please go to Settings and turn on Location Service for this app.")
            }
        }
        
    }

}
