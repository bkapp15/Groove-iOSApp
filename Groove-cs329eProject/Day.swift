//
//  Day.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 4/11/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import Foundation

class Day {
    
    //Initializing mutable property vars for class Day
    private var _dayID: Date
    private var _scheduleArray: Array<Dictionary<String, Any>> = []
    private var _availableHours: Array<Int> = []
    
    init(dayID: Date) {
        _dayID = dayID
        let sleepTime = Config.userStarSleep()
        let wakeTime = Config.userEndSleep()
        print (sleepTime)
        print (wakeTime)
        if wakeTime < sleepTime {
            for hour in wakeTime...sleepTime - 1 {
                _availableHours.append(hour)
            }
        }
        else if sleepTime <= wakeTime {
            if sleepTime != 0 {
                for hour in 0...sleepTime - 1 {
                    _availableHours.append(hour)
                }
            }
            for hour in wakeTime...23 {
                _availableHours.append(hour)
            }
        }
    }
    
    // Class-level function that will create a day object
    class func create(dayID: Date) -> Day{
        return Day(dayID: dayID)
    }
    
    var dayID:Date {
        get {
            return _dayID
        }
    }
    
    // returns formatted date object from which the day, month, and year can be retrieved as ints
    var formatDate: FormattedDate {
        get {
            return FormattedDate.create(date: dayID)
        }
    }
    
    var scheduleArray:Array<Dictionary<String, Any>> {
        get {
            return _scheduleArray
        }
    }
    
    var availableHours: Array<Int> {
        get {
            return _availableHours
        }
    }
    
    // Takes in the prioritized assignment array, assigning them to given time slots based on: numHrsEachDay and current availability
    func scheduleForDay(assignmentArray:Array<CustomAssignment>) {
        for assignment in assignmentArray {
            if !(self.dayID.isGreaterThanDate(dateToCompare: assignment.dueDate as NSDate)) {
                addEvent(assignment: assignment)
            }
        }
    }
    
    func addEvent(assignment: CustomAssignment) {
        let name: String = assignment.assignmentName
        let timeFrame: Int = assignment.numHrsEachDay
        let startTime = _availableHours[0]
        let endTime = startTime + timeFrame
        
        // Dict object of event details
        let event:Dictionary = ["eventName": name, "startTime": startTime, "endTime": endTime] as [String : Any]
        
        // Removing time frame in availableHours array
        var del = 0
        if _availableHours.count < timeFrame {
            // Error, not enough time available
            print ("The required amount of time available for this event to be added is not met. Required time: \(timeFrame) Available time: \(_availableHours.count)")
        }
        else {
            while del <= timeFrame {
                _availableHours.remove(at: 0)
                del += 1
            }
            // Appending array with startTime, endTime and name into _scheduleArray
            _scheduleArray.append(event)
        }
        
        // print(_availableHours)
    }
    
    func describe() {
        print(dayID)
        let numHoursAvailable = availableHours.count
        print("number of available hours: \(numHoursAvailable)")
        print("Events for day are below")
        print("Number of events: \(scheduleArray.count)")
        for event in scheduleArray {
            print("event name: \(event["eventName"]!), start time: \(event["startTime"]!), end time: \(event["endTime"]!)")
        }
    }
}
