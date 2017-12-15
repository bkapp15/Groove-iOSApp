//
//  QuestionaireViewController.swift
//  Groove-cs329eProject
//
//  Created by Samuel Llamas on 4/17/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import UIKit
import CoreData

class QuestionaireViewController: UIViewController {
    
    // var questions = [NSManagedObject]()


    @IBOutlet weak var wakeUpLabel: UILabel!
    @IBOutlet weak var wakeUpCounter: UIStepper!
    @IBOutlet weak var counter: UIStepper!
    @IBOutlet weak var sleepAmount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sleepCounter(_ sender: Any) {
        sleepAmount.text = "\(Int(counter.value))"
    }

    
    @IBAction func saveData(_ sender: Any) {
        saveToUserDefaults(startSleep: Int(counter.value), endSleep: Int(wakeUpCounter.value))
        print(Config.userEndSleep())
        print(Config.userStarSleep())
        
    }
    
    @IBAction func wakeUpTime(_ sender: Any) {
        if Int(wakeUpCounter.value) < 10{
        wakeUpLabel.text = "0\(Int(wakeUpCounter.value)):00"
        }
        else {
            wakeUpLabel.text = "\(Int(wakeUpCounter.value)):00"        }

    }
    
    fileprivate func saveToUserDefaults(startSleep: Int, endSleep: Int) {
        Config.setUserStartSleep(startSleep)
        Config.setUserEndSleep(endSleep)
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
