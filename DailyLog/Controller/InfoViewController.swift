//
//  InfoViewController.swift
//  DailyLog
//
//  Created by Harsha Puvvada on 3/14/20.
//  Copyright © 2020 Harsha Puvvada. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if interfaceStyle == "dark"{
            self.overrideUserInterfaceStyle = .dark
        } else{
            self.overrideUserInterfaceStyle = .light
        }
        // Do any additional setup after loading the view.
    }
}
