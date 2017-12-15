//
//  NSDate.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 4/12/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import Foundation

extension Date {
    
    // Appending day onto date object to account for problem with it returning the previous day rather than the day the date object represents
    var day:Int {return Calendar.current.component(.day, from:self.addDays(daysToAdd: 1) as Date)}
    var month:Int {return Calendar.current.component(.month, from:self.addDays(daysToAdd: 1) as Date)}
    var year:Int {return Calendar.current.component(.year, from:self.addDays(daysToAdd: 1) as Date)}
    
    // Returns date as 'yyyy-mm-dd'
    var dateString: String {
        get {
            return "\(year)-\(month)-\(day)"
        }
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays) as NSDate
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours) as NSDate
        
        //Return Result
        return dateWithHoursAdded
    }
}
