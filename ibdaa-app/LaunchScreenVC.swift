//
//  LaunchScreenVC.swift
//  ibdaa-app
//
//  Created by Killvak on 19/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    
    var x :CGFloat = 0.2
    var timer = Timer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.animated), userInfo: nil, repeats: true )
        
        perform(#selector(self.showNavController), with: nil, afterDelay: 2)
      
    
    
    }
    func animated() {
        self.arrowImageView.frame = CGRect(x: self.arrowImageView.frame.origin.x + x, y: self.arrowImageView.frame.origin.y, width: self.arrowImageView.frame.size.width, height: self.arrowImageView.frame.size.height)
        x -= 0.2
    }
    func showNavController() {
        performSegue(withIdentifier: "launchScreen", sender: self)
        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
