//
//  AppDelegate.swift
//  MyWheels
//
//  Created by deep chandan on 22/02/21.
//

import UIKit
import SideMenuSwift
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        setupSidemenu()
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func setupSidemenu()
    {
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width * 0.7
//        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
//        SideMenuController.preferences.basic.position = .under
//        SideMenuController.preferences.basic.direction = .left
       // SideMenuController.preferences.basic.defaultCacheKey = "home"
      //  SideMenuController.preferences.basic.enablePanGesture = true
       // SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
//        SideMenuController.preferences.basic.supportedOrientations = .portrait
//        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        

    }


}

