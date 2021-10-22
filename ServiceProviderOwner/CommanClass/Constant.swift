//
//  Constant.swift
//  Resolutek_Agent
//
//  Created by Amar Patil on 10/12/20.
//


import Foundation
import UIKit

let kErrorIconUnicodeString = "\u{FE57}\u{20DD} "
let kCellReUseIdentifier = "Cell"

let kAppDelegateObj = UIApplication.shared.delegate as! AppDelegate

let AppName = "Service Provider"
//let kMapBoxKey = "pk.eyJ1IjoicmlkZWxlZXAiLCJhIjoiY2thMHF6M3ptMGpmcDNtcG13NTd5dWp5biJ9.MGauZRu5lUnfJj4kC1uieA"

let kJSONFormKey = "application/json"
let kURLEncodedFormKey = "application/x-www-form-urlencoded"

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}



// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

enum Gender: String {
    case Male, Female, Other
}

enum Constant: String {
    case Return, Travel
}

let keyChainService = "myService"
let keyChainUserId = "myUserId"

enum UserDefaultKeys: String {
    case Name
    case UnitId
    case UserId
    case promoIndex
    case PhotoPic
    case savedPlace
    case homePlace
    case workPlace
    case workLat
    case workLong
    case homeLat
    case homeLong
    case saveLat
    case saveLong
    case mapLocation
    case promoCode
    case promoOffer
    case promoType

}

struct viewControllers {
    static let registration = "registration"
    static let supervisor = "supervisor"
    static let profile = "profile"
}




enum AppStoryboard: String {
    
    case main, wallet, dashboard, login, sync
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyBoardId = (viewControllerClass as UIViewController.Type).storyboardId
        return instance.instantiateViewController(withIdentifier: storyBoardId) as! T
    }
}
