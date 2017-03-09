
//
//  BookNowVC.swift
//  ibdaa-app
//
//  Created by Killvak on 01/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class BookNowVC: UIViewController {
    
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var methoudOfPaying: UILabel!
    @IBOutlet weak var estimatedMoney: UILabel!
    @IBOutlet weak var promoCode: UILabel!
    
    
    var destinationName : String?
    var coordinates : (Double,Double)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    addGestueresToLabels()
    }
    
    func addGestueresToLabels() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.locationLabelAct))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.methoudOfPayingLabelAct))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.estimatedMoneyLabelAct))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.promoCodeLabelAct))
        
        locationTitle.addGestureRecognizer(tap)
        methoudOfPaying.addGestureRecognizer(tap1)
        estimatedMoney.addGestureRecognizer(tap2)
        promoCode.addGestureRecognizer(tap3)
        
        if let destination = destinationName {
            self.locationTitle.text = destination
        }
        
    }
    
    
    
    func locationLabelAct() {
        print("Location label")
    }
    
    func methoudOfPayingLabelAct() {
        print("methoudOfPayingLabelAct label")
    }
    func estimatedMoneyLabelAct() {
        print("estimatedMoneyLabelAct label")
let googlemapV = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapsVC") as! GoogleMapsVC
        navigationController?.pushViewController(googlemapV, animated: true)
//        self.present(googlemapV, animated: true, completion: nil)

    }
    func promoCodeLabelAct() {
        print("promoCodeLabelAct label")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func bookNowBtnAct(_ sender: UIButton) {
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
