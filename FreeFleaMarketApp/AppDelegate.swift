//
//  AppDelegate.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/01/21.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?

   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let db = Database.database().reference()
        db.setValue("We've got data!")

                
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
//
            if Auth.auth().currentUser != nil {
              // User is signed in. EVENT LIST IS SHOWN
                let viewController: UIViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "eventVC") as! EventListUITableVC
                let navigationVC = UINavigationController(rootViewController: viewController)
                self.window!.rootViewController = navigationVC;
                //print("Logged in as \(user)")
            } else {
              // No user is signed in. LOGIN SCREEN IS SHOWN
                let viewController : UIViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "loginVC")
              self.window!.rootViewController = viewController;
            }
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


}

