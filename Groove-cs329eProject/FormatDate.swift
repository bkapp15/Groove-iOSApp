//
//  FormatDate.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 4/14/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import Foundation

class FormattedDate{
    
    private var _date: Date
    private let calendar: Calendar = Calendar.current
    private var _year: Int = 0
    private var _month: Int = 0
    private var _day: Int = 0
    
    init(date: Date){
        
        //initialize all properties
        _date = date
        
        _year = calendar.component(.year, from: date)
        _month = calendar.component(.month, from: date)
        _day = calendar.component(.day, from: date)
    }
    
    class func create(date: Date)->FormattedDate{
        return FormattedDate(date: date)
    }
    
    var year: Int {
        get {
            return _year
        }
    }
    
    var month: Int {
        get {
            return _month
        }
    }
    
    var day: Int {
        get {
            return _day
        }
    }
    
    var fullDate: String {
        get {
            return "\(year)-\(month)-\(day)"
        }
    }
    
    
}
