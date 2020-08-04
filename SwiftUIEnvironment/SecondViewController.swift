//
//  SecondViewController.swift
//  SwiftUIEnvironment
//
//  Created by Наталия Панферова on 3/08/20.
//  Copyright © 2020 Наталия Панферова. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, GlobalUpdating {
    
    @Global var appSettings: AppSettings

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForUpdates()
        
        // added a call to update() method  here
        // so that the title is shown on first load
        update()
    }
    
    func update() {
        print("Updating second view controller")
        navigationItem.title = appSettings.language
    }
    
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        appSettings.language = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "English"
    }
    
}
