//
//  MonthsViewController.swift
//  Groove-cs329eProject
//
//  Created by Samuel Llamas on 4/17/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class MonthsViewController: UITableViewController {
    var months = ["January", "Feburary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var assignments = [NSManagedObject]()
    var assignmentArray: Array<CustomAssignment> = []
    var dayArray: Array<Day> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Months"
        
        loadData()
        createAssignmentsAndDays()
        print("Length of dayArray: \(dayArray.count)")
        print("Length of assignmentArray: \(assignmentArray.count)")
        scheduleDays()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return months.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid1", for: indexPath)
        cell.textLabel?.text = months[indexPath.item]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        var monthDays = ["January":31, "Feburary":28, "March":31, "April":30, "May":31, "June":30, "July":31, "August":31, "September":30, "October":31, "November":30, "December":31]
        var indexPath = self.tableView.indexPathForSelectedRow!
        let monthName = months[indexPath.item]
        let destination: DaysTableViewController = segue.destination as! DaysTableViewController
        destination.numbofDays = monthDays[monthName]!
        destination.monthName = monthName
        destination.monthNum = indexPath.item + 1
        
        // Sending only the Day objects for that month
        let monthNum = indexPath.item + 1
        var monthDayArray: Array<Day> = []
        
        //
        // Need to refine this segue part, redo tests, and figure it out
        //
        for day in dayArray {

            let testingMonth = day.dayID.month
            if testingMonth == monthNum {
                print (testingMonth)
                print (day.dayID.day)
                print ("appending day: \(day.dayID)")
                monthDayArray.append(day)
            }
        }
        
        // Test monthDayArray
        print ("")
        print("testing monthDayArray")
        for day in monthDayArray {
            print (day.describe())
        }
        destination.monthDayArray = monthDayArray
        
        
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
            print (assignment.value(forKey: "assignmentName") as! String)
            let newAssignment = CustomAssignment.create(assignmentName: assignment.value(forKey: "assignmentName") as! String, estFinish: assignment.value(forKey: "etaFinish") as! Int, difficulty: assignment.value(forKey: "difficulty") as! Int, dueDate: assignment.value(forKey: "dueDate") as! Date, dateCreated: assignment.value(forKey: "dateCreated") as! Date)
            print (newAssignment.description())
            assignmentArray.append(newAssignment)
            
            
            // Check if due date of newAssignment is later
            if newAssignment.dueDate.isGreaterThanDate(dateToCompare: latestDueDate as NSDate) {
                latestDueDate = newAssignment.dueDate
                print("new latest due date")
            }
        }
        
        // Only create days when there are assignments
        if assignmentArray.count != 0 {
            // Filling dayArray with appropriate amount of days
            let numDays = latestDueDate.days(from: currentDate)
            currentDate.addDays(daysToAdd: 1)
            for i in 0...numDays {
                dayArray.append(Day.create(dayID: currentDate))
                currentDate = currentDate.addDays(daysToAdd: 1) as Date
            }
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
