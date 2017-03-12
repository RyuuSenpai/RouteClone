//
//  SigninVC.swift
//  ibdaa-app
//
//  Created by Killvak on 22/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit

class SigninVC: UIViewController {
    @IBOutlet weak var facebookBtnOL: UIButton!
    @IBOutlet weak var twitterBtnOL: UIButton!
    @IBOutlet weak var emailTextField: FloatLabelTextField!
    @IBOutlet weak var passwordTextField: FloatLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loggedInSegue", sender: self)
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
                    //                    ad.reloadApp()
                    self.performSegue(withIdentifier: "loggedInSegue", sender: self)
                    
                    //                    })
                }
            }
        }
    }
    
    //@End FB Delegate
    
    @IBAction func twitterBtnAct(_ sender: UIButton) {
        Twitter.sharedInstance().logIn { (session, err) in
            
            if session != nil {
                print("that is the user name : \(session?.userName)  "   )
                self.performSegue(withIdentifier: "loggedInSegue", sender: self)
                
            }
        }
    }
    func setUIEnabled(enabled:Bool) {
        self.facebookBtnOL.isEnabled = enabled
        //        self.googleSigninBtnOL.isEnabled = enabled
        //        self.signBtnOL.isEnabled = enabled
        //        self.dissMissView.isEnabled = enabled
        
        if enabled {
            facebookBtnOL.alpha = 1.0
            //            googleSigninBtnOL.alpha = 1.0
            //            signBtnOL.alpha = 1.0
            //            dissMissView.alpha = 1.0
            
        }else {
            facebookBtnOL.alpha = 0.5
            //            googleSigninBtnOL.alpha = 0.5
            //            signBtnOL.alpha = 0.5
            //            dissMissView.alpha = 0.5
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
