//
//  DaysTableViewController.swift
//  Groove-cs329eProject
//
//  Created by Samuel Llamas on 4/17/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit

class DaysTableViewController: UITableViewController {
    var numbofDays = 0
    var monthName = ""
    var monthNum = 0
    var monthDayArray: Array<Day> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = monthName

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        testSegueOfDays()
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
        return numbofDays
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid2", for: indexPath)
        
        cell.textLabel?.text = monthName + " " + String(indexPath.item + 1)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var indexPath = self.tableView.indexPathForSelectedRow!
        let destination: ScheduleTableViewController = segue.destination as! ScheduleTableViewController
        let chosenDayNum = indexPath.item + 1
//        destination.date = monthName + " " + String(indexPath.item + 1)
//        destination.day = indexPath.item + 1
//        destination.month = monthNum
        
        var chosenDay: Day!
        
        // Find correct day object
        for day in monthDayArray {
            if day.dayID.day == chosenDayNum {
                chosenDay = day
                break
            }
        }
        
//        print (chosenDay.dayID)
//        print (chosenDay.dayID.dateString)
//        print (chosenDay.describe())
        ///////
        if chosenDay != nil {
            destination.dayObject = chosenDay
            destination.date = chosenDay.dayID.dateString
            destination.day = chosenDay.dayID.day
            destination.month = chosenDay.dayID.month
            
        }
        else {
            // Cancel segue or do nothing?
        }
        
    }
    
    // Testing segue of correct day array
    func testSegueOfDays (){
        for day in monthDayArray{
            print(day.describe())
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
