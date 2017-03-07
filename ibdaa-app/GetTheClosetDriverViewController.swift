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

    override func viewDidLoad() {
        super.viewDidLoad()

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
