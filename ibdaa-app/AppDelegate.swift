//
//  AppDelegate.swift
//  ibdaa-app
//
//  Created by Killvak on 19/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import TwitterKit
import Fabric
import Firebase
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
           let FBhandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return FBhandled
        
        
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        FIRApp.configure()
        Fabric.with([Twitter.self])
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        L102Localizer.DoTheMagic()
        
        GMSPlacesClient.provideAPIKey("AIzaSyBNc_XSjqSnxkvhCOFGQbjYBcCq3RxhkdU")
        GMSServices.provideAPIKey("AIzaSyBNc_XSjqSnxkvhCOFGQbjYBcCq3RxhkdU")
        return true
    }

    func reloadApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
    }

    func saveUserLogginData(email:String?,photoUrl : String? , uid : String?) {
        
        if   let email = email   {
            UserDefaults.standard.setValue(email, forKey: "userEmail")
        }else{
            UserDefaults.standard.setValue(nil, forKey: "userEmail")
            
        }
        
        if  let photo = photoUrl {
            UserDefaults.standard.setValue(photo, forKey: "profileImage")
        }else {
            UserDefaults.standard.setValue(nil, forKey: "profileImage")
        }
        
        if  let uid = uid {
            UserDefaults.standard.setValue(uid, forKey: "uid")
        }else {
            UserDefaults.standard.setValue(nil, forKey: "uid")
        }
        
    }
    
    func isUserLoggedIn() -> Bool {
        if (UserDefaults.standard.value(forKey: "userEmail") != nil) {
            return true
        }else {
            return false
        }
        
    }
    
    
}
let ad = UIApplication.shared.delegate as! AppDelegate

