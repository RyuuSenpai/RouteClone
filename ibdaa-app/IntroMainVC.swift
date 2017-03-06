//
//  IntroMainVC.swift
//  ibdaa-app
//
//  Created by Killvak on 21/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class IntroMainVC: UIViewController {

    @IBOutlet weak var moveingArrowImageView: UIImageView!
    
    var arrowArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        // Do any additional setup after loading the view.
        //Sumptuous-LightItalic  , ar : MCS Tholoth S_I normal.

        movingArrow()
    }


    func movingArrow() {
        
        for x in 2...29 {
            let image = UIImage(named:"\(x)")
            self.arrowArray.append(image!)
        }
        moveingArrowImageView.animationImages = arrowArray
        moveingArrowImageView.animationDuration = 20
        moveingArrowImageView.startAnimating()
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

