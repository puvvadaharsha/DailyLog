//
//  ViewController.swift
//  DailyLog
//
//  Created by Harsha Puvvada on 3/3/20.
//  Copyright © 2020 Harsha Puvvada. All rights reserved.
//

import UIKit

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        updateToCurrentDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var tableDate: Date?
    var day = ""
    var dateButtonPress = 0
    
    //Handling table Logic
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LogBank.populateTableCells(forDays: day).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogItemCell", for: indexPath) as! CustomTableViewCell
        let row = LogBank.tableCells[indexPath.row]
//        print(row.userTitle!)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        cell.titleLabel?.text = row.userTitle
        cell.plusButton.tag = indexPath.row
        cell.minusButton.tag = indexPath.row
        cell.numberLabel?.text = "\(row.keyValues[day]!)/\(row.frequency!)"
        
        if row.keyValues[day]! != 0{
            cell.progressBar?.setProgress((Float(row.keyValues[day]!)/Float(row.frequency!)), animated: false)
            cell.progressBar?.transform.scaledBy(x: 1, y: 10)
            cell.progressBar?.tintColor = row.color!
        }else{
            cell.progressBar?.setProgress(0, animated: false)
        }
        
        cell.plusButton?.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        cell.minusButton?.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func buttonTapped(sender: UIButton){
        let row = LogBank.tableCells[sender.tag]
        
        if sender.currentTitle == "+"{
            row.addDone(for: day)
        } else{
            row.minusDone(for: day)
        }
        
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    //Handling date Logic
    @IBAction func arrowTapped(_ sender: UIButton) {
        
        var dayComponent    = DateComponents()
        let theCalendar     = Calendar.current
        sender.tag == 0 ? (dayComponent.day = -1) : (dayComponent.day = 1)
        (sender.tag == 0) ? (dateButtonPress -= 1): (dateButtonPress += 1)
        
        let nextDate  = theCalendar.date(byAdding: dayComponent, to: tableDate!)
        setDate(for: nextDate!)
        tableView.reloadData()
    }
    
    func updateToCurrentDate(){
        let date = Date()
        setDate(for: date)
    }
    
    //Dateformatter in Month XX, XXXX
    func setDate(for date:Date){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        dateLabel.text = dateFormatter.string(from: date)
        tableDate = date
        
        updateDay()
    }
    
    func updateDay(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let requested = dateFormatter.string(from: tableDate!)
        
        if dateButtonPress == 0{
            dayLabel.text = "Today"
        } else if dateButtonPress == 1{
            dayLabel.text = "Tomorrow"
        } else if dateButtonPress == -1{
            dayLabel.text = "Yesterday"
        } else{
            dayLabel.text = dateFormatter.string(from: tableDate!)
        }
        
        day = requested
    }
}

