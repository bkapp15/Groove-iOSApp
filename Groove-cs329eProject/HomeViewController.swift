//
//  HomeViewController.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 3/21/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // testDates()
        // testUserDefaults()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func deleteAssignmentsBtn(_ sender: UIButton) {
        deleteAllRecords(entity: "Assignment")
    }
    
    // Testing to see if the userdefaults persist in setting and retrieving them
    func testUserDefaults(){
        Config.setUserEndSleep(7)
        Config.setUserStartSleep(22)
        let startSleep = Config.userStarSleep()
        let endSleep = Config.userEndSleep()
        print(" end sleep: \(endSleep)")
        print("start Sleep: \(startSleep)")
    }
    
    // Deletes all Core Data records of a given entity
    func deleteAllRecords(entity:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    // Testing Date methods
    func testDates(){
        var date1 = Date()
        sleep(5)
        let date2 = Date()
        print(date1)
        print(date2)
        
        let result = date1.isGreaterThanDate(dateToCompare: date2 as NSDate)
        print(result)
        let result2 = date1.isLessThanDate(dateToCompare: date2 as NSDate)
        print (result2)
        
        date1 = date1.addDays(daysToAdd: 20) as Date
        let dayDiff = date1.days(from: date2)
        print("The day fifference is \(dayDiff)")
        print("\(dayDiff/2)")
    }

}
