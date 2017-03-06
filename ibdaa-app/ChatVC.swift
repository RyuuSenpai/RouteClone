//
//  ChatVC.swift
//  ibdaa-app
//
//  Created by Killvak on 24/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ChatVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var ref: FIRDatabaseReference?
    var databaseHandle : FIRDatabaseHandle?
    var  smsData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
     databaseHandle = ref?.child("SMS").observe(.childAdded, with: { (snapshot) in
        if let actualPost = snapshot.value as? String {
          self.smsData.insert(actualPost, at: 0)
            self.tableView.reloadData()
        }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard smsData.count > 0 else {
            return cell
        }
        cell.textLabel?.text = smsData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smsData.count
    }
    
    @IBAction func AddText(_ sender: UIBarButtonItem) {
        self.presentAlert()
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "Email?", message: "Please input your email:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                // store your data
                //                UserDefaults.standard.set(field.text, forKey: "userEmail")
                //                UserDefaults.standard.synchronize()
                //                self.smsData.append(field.text!)
                self.ref?.child("SMS").childByAutoId().setValue(field.text!)
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //    var tField: UITextField!
    //
    //    func configurationTextField(textField: UITextField!)
    //    {
    //        print("generating the TextField")
    //        textField.placeholder = "Enter an item"
    //        tField = textField
    //    }
    //
    //    func handleCancel(alertView: UIAlertAction!)
    //    {
    //        print("Cancelled !!")
    //    }
    //
    //    func xyz() {
    //    var alert = UIAlertController(title: "Enter Input", message: "", preferredStyle: .alert)
    //
    //    alert.addTextField(configurationHandler: configurationTextField)
    //    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:handleCancel))
    //    alert.addAction(UIAlertAction(title: "Done", style: .default, handler:{ (UIAlertAction) in
    //    print("Done !!")
    //
    //    print("Item : \(self.tField.text)")
    //    }))
    //    self.present(alert, animated: true, completion: {
    //    print("completion block")
    //    })
    //    }
    //
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
