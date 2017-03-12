//
//  WaitingPhoneConfirmationViewController.swift
//  ibdaa-app
//
//  Created by Killvak on 11/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import SinchVerification;

class WaitingPhoneConfirmationViewController: UIViewController {

    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var waitingLabel: UILabel!
    
    var numberOfTries = 0
    var verification:Verification!;
    var applicationKey = "64f22a95-0c76-40bb-a35a-e058a85c2c35";
    var phoneNumber : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GetLocationTitle.getLocation.animateImage(image: loadingImage , imageArray : [ UIImage(named:"callLoading")!,UIImage(named:"callLoading2")!,UIImage(named:"callLoading3")!,UIImage(named:"callLoading4")!] , duration : 1.0)
        disableUI(true);
        guard let phoneNum = phoneNumber else { return }
        verification = CalloutVerification(applicationKey,
                                           phoneNumber: "+216" +  phoneNum);
        verification.initiate { (success, error ) in
            self.disableUI(false);
            self.waitingLabel.text = (success.success ? "Verified" : error?.localizedDescription);
        }

    }

    func disableUI(_ disable: Bool){
        var alpha:CGFloat = 1.0;
        if (disable) {
            alpha = 0.5;
//             spinner.startAnimating();
            self.waitingLabel.text="";
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
            GetLocationTitle.getLocation.stopPinAnimation(image: self.loadingImage)
            
        }
        self.tryAgainButton.isEnabled = !disable;
//        self.smsButton.isEnabled = !disable;
//        self.calloutButton.isEnabled = !disable;
//        self.calloutButton.alpha = alpha;
//        self.smsButton.alpha = alpha;
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        phoneNumber.becomeFirstResponder();
        disableUI(false);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tryAgainBtnAct(_ sender: UIButton) {
        
//        self.performSegue(withIdentifier: "check", sender: self)
        numberOfTries += 1
        
        if numberOfTries == 3 {
            self.tryAgainButton.titleLabel?.text = "Skip for now"
            self.performSegue(withIdentifier: "doneWithSignUp", sender: self)
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
