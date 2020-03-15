//
//  SettingViewController.swift
//  DailyLog
//
//  Created by Harsha Puvvada on 3/12/20.
//  Copyright © 2020 Harsha Puvvada. All rights reserved.
//

import UIKit
import UserNotifications
var interfaceStyle: String?

class SettingViewController: UIViewController {
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var logItemSwitch: UISwitch!
    @IBOutlet weak var chooseTimeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var addReminderButton: UIButton!
    @IBOutlet weak var resetAllButton: UIButton!
    
    let center = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        //make sure reminders are hidden till user activates them
        makeHidden(answer: true)
    }
    
    @IBAction func darkModeTogglePress(_ sender: UISwitch) {
        //get the parent viewcontroller and change its dark mode settings
        guard let parentVC = self.parent else{return}
        guard let parent = parentVC as? UITabBarController else{return}
        if sender.isOn{
            parent.overrideUserInterfaceStyle = .dark
            interfaceStyle = "dark"
        } else{
            parent.overrideUserInterfaceStyle = .light
            interfaceStyle = "light"
        }
    }
    
    @IBAction func reminderTogglePress(_ sender: UISwitch) {
        //make label, timepicker and addreminder Button Appear
        if sender.isOn {
            makeHidden(answer: false)
        } else{
            makeHidden(answer: true)
            center.removeAllPendingNotificationRequests()
        }
    }
    
    //hide the local reminder options
    func makeHidden(answer: Bool){
        chooseTimeLabel.isHidden = answer
        addReminderButton.isHidden = answer
        timePicker.isHidden =  answer
    }
    
    //get time from time picker and create local notification
    @IBAction func addReminderPress(_ sender: UIButton) {
        //set datepickermode
        timePicker.datePickerMode = UIDatePicker.Mode.time
        
        //create a dateformatter object to convert chosen time
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        let timeChosen = dateFormatter.string(from: timePicker.date)
        
        //create an alert controller to confirm chosen time with user
        let alertController = UIAlertController(title: "Confirm?", message: "We will remind you daily at \(timeChosen) to update your log.", preferredStyle: .alert)
        
        //if user accepts, add local notification at chosen time
        let accept = UIAlertAction(title: "Ok", style: .default, handler:{_ in self.createLocalNotification(at: self.timePicker.date)})
        
        //if user cancels, remove existing notification and hide the reminder part
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {_ in
            self.makeHidden(answer: true)
            self.logItemSwitch.isOn = false
        })
        
        //add action and present alert
        alertController.addAction(cancel)
        alertController.addAction(accept)
        present(alertController, animated: true, completion: nil)
    }
    
    func createLocalNotification(at time: Date){
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.hour , Calendar.Component.minute], from: time)
        let center = UNUserNotificationCenter.current()

        //request permission to send local notifications
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler:{(granted, error) in
            if granted{
                //create trigger
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                
                //create content
                let content = UNMutableNotificationContent()
                content.title = "DailyLog Reminder"
                content.body = "Hey there, don't forget to log your items for today!"
                content.sound = UNNotificationSound.default
                
                //add request to center
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                center.add(request)
                
            }else{
                center.removeAllPendingNotificationRequests()
            }})
    }
    
    
    //reset all user input data
    @IBAction func resetAllPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset all Data", message: "Are you sure?", preferredStyle: .alert)
        let accept = UIAlertAction(title: "Confirm", style: .destructive, handler:{ _ in LogBank.resetAll()})
        let cancel = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(accept)
        
        present(alert, animated: true, completion: nil)
    }
    
}
