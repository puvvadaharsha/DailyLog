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
    var tableCells = [Logitem]()
    
    init() {}
    
    func addLogItem(item: Logitem) {
        bank.append(item)
    }
    
    func toString(){
        for item in bank{
            print(item.toString())
        }
    }
    
    func populateTableCells(forDays chosenDay:String) -> [Logitem]{
        tableCells = [Logitem]()
        let dayChosen = String(chosenDay.prefix(3))
        
        for item in bank{
            if (item.days?.contains(dayChosen))!{
                tableCells.append(item)
            }
        }
        return tableCells
    }
    
    func resetAll(){
        bank = []
        tableCells = []
    }
}
