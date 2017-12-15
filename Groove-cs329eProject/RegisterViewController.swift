//
//  RegisterViewController.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 3/21/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    var accounts = [NSManagedObject]()
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func accountCreation(_ sender: Any) {
        if (userName.text! == "" || password.text! == "") {
            let alert = UIAlertController(title: "Try again", message: "Please enter info for all fiels", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "", message: "Account created!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in self.navigationController?.popViewController(animated: true);
            }
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            saveAccount(username: userName.text!, password: password.text!)
        }

    }
    
    fileprivate func saveAccount(username: String, password: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Login", in: managedContext)
        
        let account = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        account.setValue(username, forKey: "username")
        account.setValue(password, forKey: "password")
        
        // Finally, adds entity to core data
        accounts.append(account)
        print(account)
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            //abort()
        }
        
    }

}
