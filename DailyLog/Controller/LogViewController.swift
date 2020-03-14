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
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
        @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LogBank.bank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogItemCell", for: indexPath) as! CustomTableViewCell
        let row = LogBank.bank[indexPath.row]
        
        cell.titleLabel?.text = row.userTitle
        cell.plusButton.tag = indexPath.row
        cell.minusButton.tag = indexPath.row
        cell.numberLabel?.text = "\(row.done)/\(row.frequency!)"
        
        if row.done != 0{
            cell.progressBar?.setProgress((Float(row.done)/Float(row.frequency!)), animated: false)
            cell.progressBar?.transform.scaledBy(x: 1, y: 100)
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
        let row = LogBank.bank[sender.tag]
        
        if sender.currentTitle == "+"{
            row.addDone()
        } else{
            row.minusDone()
        }
        
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    

    
}

