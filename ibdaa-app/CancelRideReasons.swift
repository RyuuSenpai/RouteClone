//
//  CancelRideReasons.swift
//  ibdaa-app
//
//  Created by Killvak on 07/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class CancelRideReasons: UIViewController {

    @IBOutlet var checkBoxBtnsOL: [UIButton]!
    var reasonForCancelation : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func reasonToCancelRide(_ sender: UIButton) {
        print("that is the sender Tag : \(sender.tag)")
     
        for x in checkBoxBtnsOL {
            x.setImage(UIImage(named:"WunChecked"), for: UIControlState.normal)
            x.isSelected = false
        }
   
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.setImage(UIImage(named:"Wchecked"), for: UIControlState.normal)
            self.reasonForCancelation = sender.tag
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
