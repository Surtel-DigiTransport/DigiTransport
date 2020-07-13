//
//  ThemeViewController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    @IBOutlet weak var darkModeToggle: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        setdarkMode()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        applyTheme()
    }
    
    func applyTheme() {
        backgroundView.backgroundColor = Theme.current.backgroundColor
        darkModeLabel.textColor = Theme.current.textColor
    }
    
    func setdarkMode() {
        if getThemeDefault() == "DarkTheme" {
            darkModeToggle.isOn = true
            
        } else {
            darkModeToggle.isOn = false
        }
    }
    
    
    @IBAction func darkModeToggleChanged(_ sender: Any) {
        if darkModeToggle.isOn {
            setThemeDefault(state: "DarkTheme")
            applyThemeDefault()
            applyTheme()
        } else {
            setThemeDefault(state: "LightTheme")
            applyThemeDefault()
            applyTheme()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
