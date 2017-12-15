//
//  AddViewController.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 3/21/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    var assignments = [NSManagedObject]()

    @IBOutlet weak var timeToFinishLabel: UILabel!
    @IBOutlet weak var estTimeCounter: UIStepper!
    @IBOutlet weak var assignName: UITextField!
    @IBOutlet weak var dueDate: UIDatePicker!
    @IBOutlet weak var difficultyCounter: UIStepper!
    @IBOutlet weak var diffifultyLevelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Will take in all the input values and assign them to entity attributes to be appended to assignments core data object
    fileprivate func saveAssignment(assignmentName: String, etaFinish: Float, dueDate: Date, difficulty: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Assignment", in: managedContext)
        
        let assignment = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        assignment.setValue(assignmentName, forKey: "assignmentName")
        assignment.setValue(etaFinish, forKey: "etaFinish")
        assignment.setValue(dueDate, forKey: "dueDate")
        assignment.setValue(difficulty, forKey: "difficulty")
        assignment.setValue(Date(), forKey: "dateCreated")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add the new entity to our array of managed objects
        assignments.append(assignment)
    }
    
    @IBAction func Counter2(_ sender: UIStepper) {
        diffifultyLevelLabel.text = "\(Int(difficultyCounter.value))"
    }
    
    @IBAction func Counter3(_ sender: UIStepper) {
        timeToFinishLabel.text = "\(Int(estTimeCounter.value))"
    }
    
    @IBAction func addAssignment(_ sender: UIButton) {
        // Assigning variables to save to data entity
        let assignmentName = assignName.text!
        let etaFinish = Float(estTimeCounter.value)
        let dueDate = self.dueDate.date
        let difficulty = Int(difficultyCounter.value)
        let currentDate = Date() // Must be greater than current date
        
        //Check the values
        print(dueDate)
        print(etaFinish)
        print(assignmentName)
        print(difficulty)
        
        // If assignmentName text field is filled out
        if (assignmentName != "") && (dueDate.isGreaterThanDate(dateToCompare: currentDate as NSDate)){
            saveAssignment(assignmentName: assignmentName, etaFinish: etaFinish, dueDate: dueDate, difficulty: difficulty)
        }
        // Alert user if text fields are missing
        else{
            errorAlert()
            
        }
    }
    
    var alertController:UIAlertController? = nil
    
    func errorAlert(){
        self.alertController = UIAlertController(title: "Error", message: "Invalid input; try again.", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    

}
