//
//  GetTheClosetDriverViewController.swift
//  ibdaa-app
//
//  Created by Killvak on 07/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class GetTheClosetDriverViewController: UIViewController {
    @IBOutlet weak var cancelRideView: UIView!

    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.layer.borderWidth = 1.5
        self.profileImage.layer.borderColor = UIColor.black.cgColor
        self.profileImage.layer.shadowColor = UIColor.black.cgColor
        let x = self.profileImage.layer
        x.shadowOffset = CGSize(width: 2, height: 2)
        x.shadowRadius = 5
        x.shadowOpacity = 0.5
        self.profileImage.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tabBarButtons(_ sender: UIButton) {
        switch sender.tag {
        case 0 : print(0)
        case 1 : print(1)
        case 2 : print  (2)
        default : print("default value for switch ")
        }
    }

    @IBAction func cancelRide(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.cancelRideView.alpha = 1
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
