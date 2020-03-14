//
//  Logbank.swift
//  DailyLog
//
//  Created by Harsha Puvvada on 3/13/20.
//  Copyright © 2020 Harsha Puvvada. All rights reserved.
//

import Foundation

class Logbank{
    var bank = [Logitem]()
    
    init() {}
    
    func addLogItem(item: Logitem) {
        bank.append(item)
    }
    
    func toString(){
        for item in bank{
            print(item.toString())
        }
    }
}
