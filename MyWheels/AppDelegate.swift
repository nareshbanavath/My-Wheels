//
//  AppDelegate.swift
//  MyWheels
//
//  Created by deep chandan on 22/02/21.
//

import UIKit
import SideMenuSwift
import IQKeyboardManagerSwift
import UserNotifications
@main


class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      IQKeyboardManager.shared.enable = true
        setupSidemenu()
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.badge, .sound]) { (granted, error) in
        if granted
        {
            print("notification Granted")
        }
        else {

//          let msg = "We can not notify you about your validity info of vehicle if notification not allowed, So please turn on notification"
//    
//          print("We can not notify you about your validity info of vehicle if notification not allowed, So please turn on notification")
//          let settinglUrl = UIApplication.openSettingsURLString
//          guard let url = URL(string: settinglUrl) else {return}
//          DispatchQueue.main.async {
//            if UIApplication.shared.canOpenURL(url)
//            {
//              UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//          }

        }
      }
        // Override point for customization after application launch.
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
    
    func setupSidemenu()
    {
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width * 0.7
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.position = .above
        SideMenuController.preferences.basic.direction = .left
       // SideMenuController.preferences.basic.defaultCacheKey = "home"
      //  SideMenuController.preferences.basic.enablePanGesture = true
       // SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
//        SideMenuController.preferences.basic.supportedOrientations = .portrait
//        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        

    }
  //for displaying notification when app is in foreground
     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

         //If you don't want to show notification when app is open, do something here else and make a return here.
         //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

         completionHandler([.alert, .badge, .sound])
     }
  func scheduleLocalNotification(title : String , body : String , date : String)
  {
    //Step1:- Create Notification Content
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default
    //Step2:- Create Trigger when to deliver the notification
    guard let dateComponents = convertStrDateToDateComps(dateStr: date) else {return}
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    //Step3 :- Create notification Request
    let uuid = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
    //Step4:- add request to notification center
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().add(request) { (error) in
      print(error?.localizedDescription as Any)
      
    }
  }
  func convertStrDateToDateComps(dateStr : String) -> DateComponents?
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    guard let date = dateFormatter.date(from: dateStr) else {return nil}
    let currentDateComps = Calendar.current.dateComponents([.year , .month , .day], from: Date())
    let givenDateComps = Calendar.current.dateComponents([.year , .month , .day], from: date)
   // if date == Da
    if currentDateComps == givenDateComps
    {
      let dateComponents = Calendar.current.dateComponents([.year ,.month ,.day , .hour , .minute , .second], from: Date().addingTimeInterval(5))
    //  dateComponents.
      print(dateComponents)
      return dateComponents
    }
    else if  date > Date()
    {
      //when date is greater than current date
      var dateComponents = Calendar.current.dateComponents([.year ,.month ,.day], from: Date())
      dateComponents.hour = 10
      print(dateComponents)
      return dateComponents
    }
    return nil
  }


}

