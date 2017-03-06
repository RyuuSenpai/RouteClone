//
//  SignupVC.swift
//  ibdaa-app
//
//  Created by Killvak on 23/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var facebookBtnOL: UIButton!
    @IBOutlet weak var twitterBtnOL: UIButton!
    @IBOutlet weak var emailTextField: FloatLabelTextField!
    @IBOutlet weak var fullNameTextField: FloatLabelTextField!
    @IBOutlet weak var passwordTextField: FloatLabelTextField!
    @IBOutlet weak var retypePasswordTextField: FloatLabelTextField!
    @IBOutlet weak var signupBtnOL: UIButton!
    @IBOutlet weak var phoneNumberTextField:
    FloatLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginBtnAct(_ sender: UIButton) {
        switch sender.tag {
        case 0 : print(1)
        case 1 : print(2)
        default : print("switch picked normal Sigup  in LoginBtnAct")
        }
    }

    @IBAction func checkBoxBtnAct(_ sender: UIButton) {
        
        if sender.tag == 0 {
            print("Social media checkBoxBtnAct")
        }else {
            print("Normal signup CheckBox")
        }
        checkBoxFuncionality(sender: sender)    
    }

    @IBAction func permitsBtnAct(_ sender: UIButton) {
        
        
    }
    
    
    func checkBoxFuncionality(sender : UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.setImage(UIImage(named:"check"), for: UIControlState.selected)
        }else {
            sender.setImage(UIImage(named:"uncheck"), for: UIControlState.normal)
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
