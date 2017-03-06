//
//  ViewController.swift
//  ibdaa-app
//
//  Created by Killvak on 19/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
class ViewController: UIViewController {
    @IBOutlet weak var fbSigninBtnOL: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTwitterButton()
    }

    func setupTwitterButton() {
        let twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("Failed to login via Twitter: ", err)
                return
            }
            
            print("Successfully logged in under Twitter...")
        }
            //lets login with Firebase
            
//            guard let token = session?.authToken else { return }
//            guard let secret = session?.authTokenSecret else { return }
//            let credentials = FIRTwitterAuthProvider.credential(withToken: token, secret: secret)
//            
//            FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
//                
//                if let err = error {
//                    print("Failed to login to Firebase with Twitter: ", err)
//                    return
//                }
//                
//                print("Successfully created a Firebase-Twitter user: ", user?.uid ?? "")
//                
//            })
//        }
        
        view.addSubview(twitterButton)
        twitterButton.frame = CGRect(x: 16, y: 116 + 66 + 66 + 66, width: view.frame.width - 32, height: 50)
    }
    
    
    func setUIEnabled(enabled:Bool) {
        self.fbSigninBtnOL.isEnabled = enabled
//        self.googleSigninBtnOL.isEnabled = enabled
//        self.signBtnOL.isEnabled = enabled
//        self.dissMissView.isEnabled = enabled
        
        if enabled {
            fbSigninBtnOL.alpha = 1.0
//            googleSigninBtnOL.alpha = 1.0
//            signBtnOL.alpha = 1.0
//            dissMissView.alpha = 1.0
            
        }else {
            fbSigninBtnOL.alpha = 0.5
//            googleSigninBtnOL.alpha = 0.5
//            signBtnOL.alpha = 0.5
//            dissMissView.alpha = 0.5
        }
        
    }
    
    //MARK: - Facebook deledate Protocoal
    
    @IBAction func fbLoginBtnAct(_ sender: AnyObject) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err ) in
            if err != nil {
                print("Custom FB Login failed",err)
                self.setUIEnabled(enabled: true)
                return
            }
            //            print(result?.token.tokenString)
            self.setUIEnabled(enabled: false)
            self.showFbEmailAddress()
        }
    }
    
    

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        self.setUIEnabled(enabled: false )
        if error != nil {
            print(error)
            self.setUIEnabled(enabled: true)
            return
        }
        
        print("Successfully logged in with facebook...")
        
        showFbEmailAddress()
    }
    
    func showFbEmailAddress(){
        self.setUIEnabled(enabled: false)
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email,first_name,last_name,picture"]).start { (connection, result, err) in
            
            if err != nil {
                self.setUIEnabled(enabled: true)
                print("failed to start graph request :  ",err)
                
            }else {
                
                let resultD = result as? NSDictionary
                if let result = resultD {
                    
                    guard let id = result["id"] as? String , let fName = result["first_name"] as? String ,let email  = result["email"] as? String  else {return }
                    print(id)
//                    self.afterLogginUserName.text = fName.capitalized
                    let imageURL = URL(string: "http://graph.facebook.com/\(id)/picture?type=large")
                    let imageString : String =  "\(imageURL!)"
                    print("that is facebook data \(id ) \(fName) \(email) \(imageString)")
//                    self.afterLogginView.fadeIn(duration: 1.5, delay: 0, completion: { (finished: Bool) in
                    
                        ad.saveUserLogginData(email: email, photoUrl: imageString , uid : id)
                        ad.reloadApp()
//                    })
                }
            }
        }
    }
    
    //@End FB Delegate
    
    @IBAction func zZZ(_ sender: UIButton) {
        var lang = "en"
        switch sender.tag {
            case 1:
                print("thatt is number ara 1 ")
    lang =  "ar"
            case 2:
                print("thatt is number eng 2 ")
//                L102Language.setAppleLAnguageTo(lang: "en")
            lang = "en"
            case 3:
                print("thatt is number fra 3 ")
//                L102Language.setAppleLAnguageTo(lang: "fr")
            lang = "fr"
            case 0:
                print("thatt is number 1 ")
            default:
                
                print("out of bound")
            }
            self.setLang(lang: lang)
//            var transition: UIViewAnimationOptions = .transitionFlipFromLeft
//            if L102Language.currentAppleLanguage() == "en" || L102Language.currentAppleLanguage() == "fr" {
//                //            L102Language.setAppleLAnguageTo(lang: "ar")
//                UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            } else {
//                //            L102Language.setAppleLAnguageTo(lang: "en")
//                transition = .transitionFlipFromRight
//                UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            }
//            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//            rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
//            let mainwindow = (UIApplication.shared.delegate?.window!)!
//            mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//            UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
//            }) { (finished) -> Void in
//                
//            }
    }
    
    @IBAction func signOutBtnAct(_ sender: UIButton) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        print("loggedout")
        ad.saveUserLogginData(email: nil, photoUrl: nil , uid : nil)
        ad.reloadApp()
    }
    
    
    func setLang(lang:String) {
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() == "en" || L102Language.currentAppleLanguage() == "fr" {
            L102Language.setAppleLAnguageTo(lang: lang)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else if L102Language.currentAppleLanguage() == "ar" || L102Language.currentAppleLanguage() == "fr" {
            L102Language.setAppleLAnguageTo(lang: lang)
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else  if L102Language.currentAppleLanguage() == "en" || L102Language.currentAppleLanguage() == "ar" {
            
            L102Language.setAppleLAnguageTo(lang: lang)
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
//    @IBAction func GOGOGOGO(_ sender: UIButton) {
//        switch sender.tag {
//        case 1:
//            print("thatt is number ara 1 ")
//            L102Language.setAppleLAnguageTo(lang: "ar")
//        case 2:
//            print("thatt is number eng 2 ")
//            L102Language.setAppleLAnguageTo(lang: "en")
//        case 3:
//            print("thatt is number fra 3 ")
//            L102Language.setAppleLAnguageTo(lang: "fr")
//        case 0:
//            print("thatt is number 1 ")
//        default:
//            
//            print("out of bound")
//        }  
//        
//        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
//        if L102Language.currentAppleLanguage() == "en" || L102Language.currentAppleLanguage() == "fr" {
////            L102Language.setAppleLAnguageTo(lang: "ar")
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        } else {
////            L102Language.setAppleLAnguageTo(lang: "en")
//            transition = .transitionFlipFromRight
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        }
//        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
//        let mainwindow = (UIApplication.shared.delegate?.window!)!
//        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
//        }) { (finished) -> Void in
//            
//        }
//    }
    
    
     func changelangBtnAct() {
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() == "en" || L102Language.currentAppleLanguage() == "fr" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else if L102Language.currentAppleLanguage() == "ar" || L102Language.currentAppleLanguage() == "fr" {
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else  if L102Language.currentAppleLanguage() == "en" || L102Language.currentAppleLanguage() == "ar" {

            L102Language.setAppleLAnguageTo(lang: "fr")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
    func changelangBtnAct2() {
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() == "en"  {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else  {
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }

}

