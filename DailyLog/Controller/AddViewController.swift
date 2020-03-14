//
//  AddViewController.swift
//  DailyLog
//
//  Created by Harsha Puvvada on 3/12/20.
//  Copyright © 2020 Harsha Puvvada. All rights reserved.
//

import UIKit

class AddViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet var dayButtons: [UIButton]!
    @IBOutlet var colorButtons: [UIButton]!
    
    
    var frequency: Int = 1
    var userTitle: String = ""
    var days: [String] = []
    var color: UIColor?
    
    //get input title and input validation
    @IBAction func titleTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        
        guard let input = titleTextField.text else {return}
        //make sure title input is between 1 and 16 characters
        if (input.count > 16 || input.count < 1){
            
            let alert = UIAlertController(title: "Invalid title length", message: "Title should be between 1 and 16 characters", preferredStyle: .alert)
            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okay)
            present(alert, animated: true, completion: nil)
            sender.text = ""
            
        } else{
            userTitle = input
        }
    }
    
    //update frequency count via stepper
    @IBAction func stepperPress(_ sender: UIStepper) {
        frequency = Int(sender.value)
        frequencyLabel.text = String(frequency)
    }
    
    //change state of day button when pressed
    @IBAction func dayButtonPress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let currentTitle = sender.currentTitle else {return}
        
        if sender.isSelected {
            sender.backgroundColor = UIColor.systemGray3
            sender.layer.cornerRadius = 10
            sender.clipsToBounds = true
            if !days.contains(currentTitle){
                days.append(currentTitle)
            }
        } else{
            sender.backgroundColor = UIColor.systemBackground
            if let index = days.firstIndex(of: currentTitle){
                days.remove(at: index)
            }
        }
    }
    
    @IBAction func colorPressed(_ sender: UIButton) {
        for item in colorButtons{
            if item != sender{
                item.layer.opacity = 0.5
                item.isSelected = false
            } else{
                item.layer.opacity = 1
                item.isSelected = true
                color = sender.backgroundColor!
            }
        }
    }
    
    @IBAction func addItemPress(_ sender: UIButton) {
        if userTitle.isEmpty || color == nil || days.isEmpty{
            
            let alert = UIAlertController(title: "Missing Data", message: "Please make sure to fill out all the fields", preferredStyle: .alert)
            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okay)
            present(alert, animated: true, completion: nil)
            
        } else{
            
            print("\(userTitle), \(frequency), \(color!)" )
            for item in days{
                print(item)
            }
            
        }
    }
}

