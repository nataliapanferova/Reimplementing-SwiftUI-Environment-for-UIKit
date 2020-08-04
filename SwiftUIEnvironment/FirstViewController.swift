//
//  ViewController.swift
//  SwiftUIEnvironment
//
//  Created by Наталия Панферова on 3/08/20.
//  Copyright © 2020 Наталия Панферова. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, GlobalUpdating {
    
    @Global var userSettings: UserSettings

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForUpdates()
        
        // added a call to update() method  here
        // so that the title is shown on first load
        update()
    }
    
    func update() {
        print("Updating first view controller")
        navigationItem.title = userSettings.authenticationString
    }

    @IBAction func authenticate(_ sender: UIButton) {
        userSettings.isAuthenticated.toggle()
    }
    
}

