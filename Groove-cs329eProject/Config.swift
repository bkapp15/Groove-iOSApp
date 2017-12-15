//
//  Config.swift
//  Groove-cs329eProject
//
//  Created by bak792 on 4/11/17.
//  Copyright © 2017 cs329e. All rights reserved.
//

import Foundation

// This class contains methods for setting and storing user defaults of when the user goes to sleep, wakes up, and their preffered study time
class Config: NSObject {
    // Define keys for the values to store
    fileprivate static let kUserStartSleepKey = "userStartSleep"
    fileprivate static let kUserEndSleepKey = "userEndSleep"
    fileprivate static let kUserStudyPrefKey = "userStudyPref"
    
    // Sets the user defaults of userStartSleep, userEndSleep, userStudyPref
    class func setUserStartSleep(_ userStartSleep:Int) {
        UserDefaults.standard.set(userStartSleep, forKey: kUserStartSleepKey)
        UserDefaults.standard.synchronize()
    }
    class func setUserEndSleep(_ userEndSleep:Int) {
        UserDefaults.standard.set(userEndSleep, forKey: kUserEndSleepKey)
        UserDefaults.standard.synchronize()
    }
    
    class func setUserStudyPref(_ userStudyPref:String) {
        UserDefaults.standard.set(userStudyPref, forKey: kUserEndSleepKey)
        UserDefaults.standard.synchronize()
    }
    
    // Returns the User Default values for given keys
    class func userStarSleep() -> Int {
        return UserDefaults.standard.integer(forKey: kUserStartSleepKey)
    }
    class func userEndSleep() -> Int {
        return UserDefaults.standard.integer(forKey: kUserEndSleepKey)
    }
    class func userStudyPref() -> String {
        return UserDefaults.standard.object(forKey: kUserStudyPrefKey) as! String
    }
}
