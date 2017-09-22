//
//  AppDelegate.swift
//  HelloAWSSNS
//
//  Created by Austin Chen on 2017-09-13.
//  Copyright © 2017 ACCodeworks Inc. All rights reserved.
//

import UIKit
import AWSCore
import AWSSNS
import UserNotifications

/* test using
 http://pushtry.com
 */

/* Do NOT really need this
 <key>NSAppTransportSecurity</key>
	<dict>
 <key>NSExceptionDomains</key>
 <dict>
 <key>amazonaws.com</key>
 <dict>
 <key>NSIncludesSubdomains</key>
 <true/>
 <key>NSThirdPartyExceptionMinimumTLSVersion</key>
 <string>TLSv1.0</string>
 <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
 <false/>
 </dict>
 <key>amazonaws.com.cn</key>
 <dict>
 <key>NSIncludesSubdomains</key>
 <true/>
 <key>NSThirdPartyExceptionMinimumTLSVersion</key>
 <string>TLSv1.0</string>
 <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
 <false/>
 </dict>
 </dict>
	</dict>
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AWSDDLog.sharedInstance.logLevel = .verbose
        
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: .USEast1,
            identityPoolId: "us-east-1:dd270951-49f1-4a1d-9847-6a71c798ad15")
        let configuration = AWSServiceConfiguration(
            region: .USEast1,
            credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        if true {
            // ios 10 and above
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            // ios 9 and below
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let sns = AWSSNS.default()
        let request = AWSSNSCreatePlatformEndpointInput()
        request?.token = (deviceToken as NSData).hexString
        print("Device token: %@", request!.token ?? "")
        request?.platformApplicationArn = "arn:aws:sns:us-east-1:173521265788:app/APNS_SANDBOX/HelloSNSDev"
        
        sns.createPlatformEndpoint(request!).continueOnSuccessWith { (task) -> Any? in
            let response = task.result
            
            let subscribeRequest = AWSSNSSubscribeInput()
            subscribeRequest?.endpoint = response?.endpointArn
            subscribeRequest?.protocols = "application"
            subscribeRequest?.topicArn = "arn:aws:sns:us-east-1:173521265788:HelloSNSTopic1"
            
            print(subscribeRequest!)
            return sns.subscribe(subscribeRequest!)
            
            }.continueWith { (task) -> Any? in
                if task.isCancelled {
                    print("task cancelled")
                } else if task.error != nil {
                    print("Error occurred: %@", task.error!.localizedDescription)
                } else {
                    print("Successfully subscribed to all endpoint")
                }
                return nil
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        switch application.applicationState {
            
        case .inactive:
            print("Inactive")
            //Show the view with the content of the push
            completionHandler(.newData)
            
        case .background:
            print("Background")
            //Refresh the local model
            completionHandler(.newData)
            
        case .active:
            print("Active")
            //Show an in-app banner
            completionHandler(.newData)
        }
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

