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
    var done: Int = 0
    
    init(logItem userTitle: String,timesDaily frequency: Int,On days:[String],withColor color:UIColor) {
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
    
    func addDone(){
        done += 1
        if done >= frequency!{
            done = frequency!
        }
    }
    
    func minusDone(){
        done -= 1
        if done <= 0{
            done = 0
        }
    }
}
