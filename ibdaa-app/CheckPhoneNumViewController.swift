//
//  CheckPhoneNumViewController.swift
//  ibdaa-app
//
//  Created by Killvak on 11/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import SinchVerification;

class CheckPhoneNumViewController: UIViewController {
    @IBOutlet weak var phoneNumber: UITextField!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var status: UILabel!
    
    var verification:Verification!;
    var applicationKey = "64f22a95-0c76-40bb-a35a-e058a85c2c35";  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func test() {
 

    }
    
    @IBAction func calloutVerification(_ sender: UIButton) {
        disableUI(true);
	
        
        verification = CalloutVerification(applicationKey,
                                           phoneNumber:  phoneNumber.text!);
//        verification.initiate { (result: InitiationResult, error: NSError?) -> Void in
//            self.disableUI(false);
//            self.status.text = (success.success ? "Verified" : error?.localizedDescription);
//        }
        verification.initiate { (InitiationResult, err ) in
            
            self.disableUI(false);
            guard err == nil else {    self.status.text =  "\(err?.localizedDescription)"; print("Not Verified Phone \(err?.localizedDescription)") ;return }
            self.status.text =  " Verified"
        }
    }
    func disableUI(_ disable: Bool){
        var alpha:CGFloat = 1.0;
        if (disable) {
            alpha = 0.5;
            phoneNumber.resignFirstResponder();
            spinner.startAnimating();
            self.status.text="";
            let delayTime =
                DispatchTime.now() +
                    Double(Int64(30 * Double(NSEC_PER_SEC)))
                    / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(
                deadline: delayTime, execute:
                { () -> Void in
                    self.disableUI(false);
            });
        }
        else{
            self.phoneNumber.becomeFirstResponder();
            self.spinner.stopAnimating();
            
        }
        self.phoneNumber.isEnabled = !disable;
//        self.smsButton.isEnabled = !disable;
//        self.calloutButton.isEnabled = !disable;
//        self.calloutButton.alpha = alpha;
//        self.smsButton.alpha = alpha;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        phoneNumber.becomeFirstResponder();
        disableUI(false);
        
    }
    
    @IBAction func smsVerification(_ sender: UIButton) {
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
