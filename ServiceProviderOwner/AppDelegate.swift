//
//  AppDelegate.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 03/06/21.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import FirebaseMessaging
import Firebase
import FirebaseDynamicLinks
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        if launchOptions != nil {
            let dict = launchOptions![UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable : Any]
            if dict != nil {
                clearAPNSNotifications()
            }
        }
        
//        if  UIApplication.shared.applicationIconBadgeNumber == 0
//        {
//        UIApplication.shared.applicationIconBadgeNumber = 1
//        }

        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
       
        application.registerForRemoteNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    func clearAPNSNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }

}


extension AppDelegate {
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        clearAPNSNotifications()
      
        if userInfo[gcmMessageIDKey] != nil {
           // print("Message ID: \(messageID)")
        }
//        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
//        badge.count = userInfo.count
        
        // Print full message.
     //   print(userInfo)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.clearAPNSNotifications()
       
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if userInfo[gcmMessageIDKey] != nil {
           // print("Message ID: \(messageID)")
        }
//        badge.count = userInfo.count
//        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
        // Print full message.
        print(userInfo)
       
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
//        UserDefaults.standard.set(deviceToken, forKey: "token_device")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)}).uppercased()
        

//        badge.count = +1

//        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification")))
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
//        badge.count = userInfo.count
        
//        let count = UIApplication.shared.applicationIconBadgeNumber + 1
//        UIApplication.shared.applicationIconBadgeNumber = count
        
        // Change this to your preferred presentation option
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(Notification(name: Notification.Name("didReceiveNotification1")))
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
//        badge.count = userInfo.count
//        if UIApplication.shared.applicationIconBadgeNumber != 0
//        {
//        let count = UIApplication.shared.applicationIconBadgeNumber - 1
//        UIApplication.shared.applicationIconBadgeNumber = count
//        }
        
        completionHandler()
    }
    
}
 
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]  same at line 87
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        UserDefaults.standard.set(fcmToken!, forKey: "deviceToken")

    }

//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//    }
    // [END ios_10_data_message]
    
    // upper se chaka gya
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        UserDefaults.standard.set(token, forKey: "deviceToken")
    }
}





