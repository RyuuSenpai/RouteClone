//
//  SideMenuVC.swift
//  White_Label
//
//  Created by Killvak on 23/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var imageList = [UIImage]()
    var titleOfImage = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imageList = [ UIImage(named:"MMHome")! , UIImage(named:"MMList")!,UIImage(named:"MMHome")!,UIImage(named:"MMHome")!]
        titleOfImage = ["Home" , " Setting ", " Share", "profile"]
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return  imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        cell.imageView?.image = imageList[indexPath.row]
        cell.title.text = titleOfImage[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealVC : SWRevealViewController = self.revealViewController()
        
        let cell = tableView.cellForRow(at: indexPath) as! SideMenuCell

        var destinationVC : UIViewController!
        switch cell.title.text! {
        case "Home":
            print("HOME ")
             destinationVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPageVC") as! MainPageVC
        case "Home":
            print("setting  ")
        case "Home":
            print("Share ")
        case "Home":
            print("Profile Selected ")
        default:
            print("switch default did select from side menu  ")
            destinationVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPageVC") as! MainPageVC
        }
        
        let newFrontVC = UINavigationController.init(rootViewController: destinationVC)
        revealVC.pushFrontViewController(newFrontVC, animated: true)
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
