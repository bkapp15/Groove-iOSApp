//
//  ScheduleTableViewController.swift
//  Groove-cs329eProject
//
//  Created by Samuel Llamas on 4/17/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
// import CoreData

class ScheduleTableViewController: UITableViewController {
    
    var date = ""
    var day = 0
    var month = 0
    // var counter = 0
    // var postedName = [String]()
    
    var dayObject: Day?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = date
        
        // testDaySegue()
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
        if dayObject != nil {
            return dayObject!.scheduleArray.count
        }
        else {
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid3", for: indexPath)
        
        let event = dayObject!.scheduleArray[indexPath.item]
        let eventName = event["eventName"] as! String?
        let timeFrameString = "\(event["startTime"]!):00 - \(event["endTime"]!):00"
        
        cell.textLabel?.text = eventName
        cell.detailTextLabel?.text = timeFrameString
        
        
        return cell
    }
    
        // let sleepAmount = questions[questions.endIndex - 1].value(forKey: "sleep")! as! Int
//        cell.detailTextLabel?.text = ""
//        
//        if indexPath.item < sleepAmount {
//            cell.detailTextLabel?.text = "Sleep"
//        }
//        
//        var posted = false
//        for index in 0...(assignments.endIndex - 1) {
//            let fake = Calendar.current
//            let test = assignments[index].value(forKey: "dueDate") as! Date
//            let testDay = fake.component(.day, from: test)
//            let testmonth = fake.component(.month, from: test)
//            let hours = assignments[index].value(forKey: "etaFinish") as! Int
//            let assignName = assignments[index].value(forKey: "assignmentName") as! String
//        
//            if testmonth == month && testDay >= day && cell.detailTextLabel?.text == "" && postedName.contains(assignName) == false {
//                cell.detailTextLabel?.text = assignName
//                print(hours, assignName)
//                counter += 1
//                print(counter)
//                if counter == hours {
//                    postedName.append(assignName)
//                    counter = 0
//                }
//                posted = true
//            }
//            
//        }
//        
//        if indexPath.item == 0 {
//            cell.textLabel?.text = String(indexPath.item + 12) + ":00 AM"
//        }
//        else if (indexPath.item) <= 12 {
//            cell.textLabel?.text = String(indexPath.item) + ":00 AM"
//        }
//        else {
//            cell.textLabel?.text = String(indexPath.item - 12) + ":00 PM"
//        }
//        
//        if indexPath.item < sleepAmount {
//            cell.detailTextLabel?.text = "Sleep"
    

//    fileprivate func loadData(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Questionaire")
//        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName:"Assignment")
//        
//        var fetchedResults:[NSManagedObject]? = nil
//        var fetchedResults2:[NSManagedObject]? = nil
//        
//        do {
//            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
//            try fetchedResults2 = managedContext.fetch(fetchRequest2) as? [NSManagedObject]
//        } catch {
//            // what to do if an error occurs?
//            let nserror = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//            abort()
//        }
//        
//        if let results = fetchedResults, let results2 = fetchedResults2 {
//            questions = results
//            assignments = results2
//        } else {
//            print("Could not fetch")
//        }
//    }
    
    func testDaySegue() {
        print("")
        print ("Testing Day Segue")
        print ("dayID: \(dayObject?.dayID)")
        print ("Day's events:")
        for event in (dayObject?.scheduleArray)! {
            print (event.description)
        }
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
