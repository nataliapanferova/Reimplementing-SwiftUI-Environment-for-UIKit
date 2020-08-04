//
//  ThirdViewController.swift
//  SwiftUIEnvironment
//
//  Created by Наталия Панферова on 3/08/20.
//  Copyright © 2020 Наталия Панферова. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, GlobalUpdating {
    
    @Global var userSettings: UserSettings
    @Global var appSettings: AppSettings
    
    @IBOutlet weak var authenticationStatus: UILabel!
    @IBOutlet weak var language: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForUpdates()
        
        // added a call to update() method here so that
        // when the view is first loaded it updates the labels
        // to reflect the current state of UserSettings and AppSettings
        update()
    }
    
    func update() {
        print("Updating third view controller")
        authenticationStatus.text = userSettings.authenticationString
        language.text = appSettings.language
        navigationItem.title = "Summary"
    }

}
