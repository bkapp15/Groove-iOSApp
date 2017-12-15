//
//  TestAssignmentRetViewController.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 4/14/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class TestAssignmentRetViewController: UIViewController {

    var assignments = [NSManagedObject]()
    var assignmentArray: Array<CustomAssignment> = []
    var dayArray: Array<Day> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        createAssignmentsAndDays()
        print("Length of dayArray: \(dayArray.count)")
        print("Length of assignmentArray: \(assignmentArray.count)")
        scheduleDays()

        // Do any additional setup after loading the view.
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
    
    fileprivate func scheduleDays() {
        for day in dayArray {
            day.scheduleForDay(assignmentArray: assignmentArray)
            print("Scheduled day")
            print(day.describe())
        }
    }
    
    fileprivate func createAssignmentsAndDays() {
        // Create an assignment object and put Core Data values into objects for each Core Data entity found
        // Create array of Assignment objects sorted by difficulty
        // var assignmentArray:Array<CustomAssignment> = []
        
        // Find out when latest due date is, then fill dayArray with Day objects up to that date
        var latestDueDate = Date()
        
        var currentDate = Date()
        
        for assignment in assignments {
            
            // Retrieving vals from core data
            // And assigning them to assignment object attributes
            let newAssignment = CustomAssignment.create(assignmentName: assignment.value(forKey: "assignmentName") as! String, estFinish: assignment.value(forKey: "etaFinish") as! Int, difficulty: assignment.value(forKey: "difficulty") as! Int, dueDate: assignment.value(forKey: "dueDate") as! Date, dateCreated: assignment.value(forKey: "dateCreated") as! Date)
            print (newAssignment.description())
            assignmentArray.append(newAssignment)

            
            // Check if due date of newAssignment is later
            if newAssignment.dueDate.isGreaterThanDate(dateToCompare: latestDueDate as NSDate) {
                latestDueDate = newAssignment.dueDate
                print("new latest due date")
            }
        }
        
        // Filling dayArray with appropriate amount of days
        let numDays = latestDueDate.days(from: currentDate)
        currentDate.addDays(daysToAdd: 1)
        for i in 0...numDays {
            dayArray.append(Day.create(dayID: currentDate))
            currentDate = currentDate.addDays(daysToAdd: 1) as Date
        }
    }
    
    // Returns true if date has matching Day object in array
    func dayExistsIn(date:Date, array:Array<Day>) -> Bool {
        for day in array {
            if day.dayID == date {
                return true
            }
        }
        return false
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
