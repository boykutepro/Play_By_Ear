//
//  AppDelegate.swift
//  project
//
//  Created by Mac on 7/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn

import UserNotifications
//import GoogleMobileAds
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    // config Status Bar & Keyboard
     IQKeyboardManager.shared.enable = true
    //UIApplication.shared.statusBarStyle = .lightContent
    
    //  Define Splash VC
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MainNavigationController()
    window?.makeKeyAndVisible()
    
    if let historyData = UserDefaults.standard.value(forKey: "FAVORITE_LESSON") as? [[String: AnyObject]] {
        for book in historyData {
            FAVORITE_LESSON.append(Lesson(data: book))
        }
    }
    
    if let downloaded = UserDefaults.standard.value(forKey: "DOWNLOADED_LESSON") as? [[String: AnyObject]] {
        for book in downloaded {
            DOWNLOADED_LESSON.append(Lesson(data: book))
        }
    }
    
    // Config Facebook
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENT_KEY
    
    // firebase
    configureFireBase(application)
    
    return true
  }
    
    
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        FIRSetAPNs(deviceToken: deviceToken)

  }
    
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    
    GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    
    return true
  }
  
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    AppEvents.activateApp()
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  // MARK : Configure Firebase
  func configureFireBase(_ application: UIApplication)  {
        
        
//    Messaging.messaging().remoteMessageDelegate = self
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()
    
        FirebaseApp.configure()
        
    }

    func FIRSetAPNs(deviceToken: Data) {
//        InstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.prod)
//        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X",    $1)})
//        print("deviceToken: \(tokenString)")
    }
    
  
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[Global.FCM_KEY_SERVER] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[Global.FCM_KEY_SERVER] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
        
    }
}

extension AppDelegate : MessagingDelegate{
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print("FIRMessagingDelegate \(remoteMessage.appData)")
    }
}

