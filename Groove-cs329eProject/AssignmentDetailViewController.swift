//
//  AssignmentDetailViewController.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 3/21/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class AssignmentDetailViewController: UIViewController {
    var assignments = [NSManagedObject]()
    
    var assignment: NSManagedObject?
    
    @IBOutlet weak var timeBar: UILabel!
    
    @IBOutlet weak var duedateBar: UILabel!
    
    @IBOutlet weak var difficultyBar: UILabel!
    
    @IBOutlet weak var detailBar: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Formatting date object to use as a string
        let dateFormatter = DateFormatter()
        var dueDate = assignment?.value(forKey: "dueDate")
        dateFormatter.dateStyle = DateFormatter.Style.short
        dueDate = dateFormatter.string(from: dueDate as! Date)
        // Check the date conversion to string
        duedateBar.text = dueDate as? String
        let time =  assignment?.value(forKey: "etaFinish") as? Int
        if time! == 1 {
            timeBar.text = String(time!) + " hour"
        }
        else if time! > 1{
            timeBar.text = String(time!) + " hours"

        }
        let difficult = assignment?.value(forKey: "difficulty") as? Int
        difficultyBar.text = String(difficult!)
        
        // Do any additional setup after loading the view.
        //let timeBarStr = NSString(format: "%.2f", assignment?.value(forKey: "etaFinish") as! CVarArg)
        
        //let difficultyBarStr = "\(assignment?.value(forKey: "difficulty"))"
        
        //timeBar.text = timeBarStr as String!
        
        //timeBar.text = assignmen?       duedateBar.text = assignment?.value(forKey: "dueDate") as! String?
        //difficultyBar.text = difficultyBarStr as String!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Assignment")
        
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
            assignments = results
        } else {
            print("Could not fetch")
        }
    }

}
