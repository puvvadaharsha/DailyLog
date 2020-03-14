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
}
