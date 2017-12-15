//
//  CustomAssignment.swift
//  Groove-cs329eProject
//
//  Created by Chien Chih Huang on 4/11/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import Foundation

class CustomAssignment{
    
    private var _assignmentName:String = ""
    private var _estFinish:Int = 0
    private var _difficulty:Int = 0
    private var _dueDate: Date
    private var _numHrsEachDay = 0
    private var _dateCreated: Date
    
    
    init(assignmentName:String, estFinish:Int, difficulty:Int, dueDate: Date, dateCreated: Date){
        
        //initialize all properties
        _assignmentName = assignmentName
        _estFinish = estFinish
        _difficulty = difficulty
        _dueDate = dueDate
        _dateCreated = dateCreated
        let daysTilDue = dueDate.days(from: dateCreated) + 1
        print("Days til dueDate: \(daysTilDue)")
        _numHrsEachDay = estFinish/daysTilDue
    }
    
    class func create(assignmentName:String, estFinish:Int, difficulty:Int, dueDate: Date, dateCreated: Date)->CustomAssignment{
        return CustomAssignment(assignmentName:assignmentName, estFinish:estFinish, difficulty:difficulty, dueDate: dueDate, dateCreated: dateCreated)
    }
    
    var assignmentName:String {
        get {
            return _assignmentName
        }
    }
    
    var estFinish:Int {
        get {
            return _estFinish
        }
    }

    var difficulty:Int {
        get {
            return _difficulty
        }
    }

    var dueDate:Date {
        get {
            return _dueDate
        }
    }
    
    var numHrsEachDay:Int {
        get {
            return _numHrsEachDay
        }
    }
    
    var dateCreated: Date {
        get {
            return _dateCreated
        }
    }

    
    func description()->String{
        return "Name:\(assignmentName), Estimated Hours:\(estFinish), Difficulty:\(difficulty), Due Date:\(dueDate), Daily Study Hours:\(numHrsEachDay), Date Created: \(dateCreated)"
    }
    
    // Returns whether the difficulty of object is higher than the other
//    func isPriority(other:Assignment) -> Bool {
//        return self.difficulty > other.difficulty
//    }
    
    
}
