//
//  LoginViewController.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 3/21/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    var accounts = [NSManagedObject]()
    var accountFound: Bool = false

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        if (userName.text == "") || (password.text == "") {
            let failAlert = UIAlertController(title: "Login Failed", message: "Username or password incorrect. Please try again.", preferredStyle: .alert)
            print (userName.text!)
            print (password.text!)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action: UIAlertAction) in
                print("fail Alert OK pressed")
            }
            failAlert.addAction(OKAction)
            self.present(failAlert,animated: true, completion: nil)
        }
        
        else {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let loginEntity = NSEntityDescription.entity(forEntityName: "Login", in: managedContext)
            
            let user = NSManagedObject(entity: loginEntity!, insertInto: managedContext)
            user.setValue(password.text!, forKey: "password")
            user.setValue(userName.text!, forKey: "username")
            
            for account in accounts {
                let accountName = String(describing: account.value(forKey: "username"))
                let inputName = String(describing: user.value(forKey: "username"))
                let accountPassword = String(describing: account.value(forKey: "password"))
                let inputPassword = String(describing: user.value(forKey: "password"))
                
                if (accountName == inputName && accountPassword == inputPassword) {
                    accountFound = true
                }
            }
           
        }
        
        if accountFound{
            self.accountFound = false
            self.performSegue(withIdentifier: "loggedIn", sender: self)
            
        }
        else {
            let failAlert = UIAlertController(title: "Login Failed", message: "Username or password incorrect. Please try again.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action: UIAlertAction) in
                print("fail Alert OK pressed")
            }
            failAlert.addAction(OKAction)
            self.present(failAlert,animated: true, completion: nil)
        }
        
    }
    
    fileprivate func loadData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Login")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            accounts = results
        } else {
            print("Could not fetch")
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

