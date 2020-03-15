//
//  Logitem.swift
//  DailyLog
//
//  Created by Harsha Puvvada on 3/13/20.
//  Copyright © 2020 Harsha Puvvada. All rights reserved.
//

import UIKit

class Logitem{
    
    let userTitle: String?
    let frequency: Int?
    let days: [String]?
    let color: UIColor?
    var keyValues = ["Monday" : 0, "Tuesday" : 0, "Wednesday" : 0, "Thursday" : 0, "Friday" : 0, "Saturday" : 0, "Sunday" : 0]
    
    init(logItem userTitle: String,timesDaily frequency: Int,On days:[String], withColor color:UIColor) {
        self.userTitle = userTitle
        self.frequency = frequency
        self.days = days
        self.color = color
    }
    
    func toString(){
        print("\(userTitle!), \(frequency!), \(color!)" )
        for item in days!{
            print(item)
        }
    }

    func addDone(for Day: String){
        keyValues[Day]! += 1
        if keyValues[Day]! >= frequency!{
            keyValues[Day] = frequency!
        }
    }
    
    func minusDone(for Day: String){
        keyValues[Day]! -= 1
        if keyValues[Day]! <= 0{
            keyValues[Day] = 0
        }
    }
}
