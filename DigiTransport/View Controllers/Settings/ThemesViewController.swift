//
//  ThemeViewController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

import UIKit

class ThemesViewController: UIViewController {
    @IBOutlet weak var spacer: UIView!

    @IBOutlet weak var overrideThemeDesc: UILabel!
    @IBOutlet weak var overrideSystemTheme: UILabel!
    
    @IBOutlet weak var overrideThemeToggle: UISwitch!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var lightButton: RadioButton!
    
    @IBOutlet weak var darkButton: RadioButton!
    @IBOutlet weak var lightText: UILabel!
    @IBOutlet weak var darkText: UILabel!
    
    @IBOutlet weak var appearanceLabel: UILabel!
    
    @IBOutlet var interactiveView: UIScrollView!
    
    
    @IBOutlet weak var DigiTransportDark: UIImageView!
    
    @IBOutlet weak var DigiTransportLight: UIImageView!
    
    var DigiTransportLogos = [UIImageView]()
    let themeOverrideDefaults = UserDefaults.standard
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DigiTransportLogos.append(DigiTransportDark)
        DigiTransportLogos.append(DigiTransportLight)
        let DarkGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(darkThemePressed(_:)))
        DigiTransportDark.isUserInteractionEnabled = true
        DigiTransportDark.addGestureRecognizer(DarkGestureRecognizer)
        
        let LightGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lightThemePressed(_:)))
        DigiTransportLight.isUserInteractionEnabled = true
        DigiTransportLight.addGestureRecognizer(LightGestureRecognizer)
        
        interactiveView.alwaysBounceVertical = true
        interactiveView.showsHorizontalScrollIndicator = false
        interactiveView.showsVerticalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        setThemeOverride()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        applyTheme()
        if overrideThemeToggle.isOn {
            themeOverrideDefaults.set(true, forKey: "systemTheme")

        } else {
            themeOverrideDefaults.set(false, forKey: "systemTheme")
        }
        setdarkMode()
    }

    
    
    
    @objc func applyTheme() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            applyThemeDefault()
            for i in 0..<self.DigiTransportLogos.count {
                let imageView = self.DigiTransportLogos[i]
                imageView.layer.shadowColor = Theme.current.oppositegrays.cgColor
                imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
                imageView.layer.shadowOpacity = 1
                imageView.layer.shadowRadius = 1.0
                imageView.clipsToBounds = false
            }
            
            self.interactiveView.backgroundColor = Theme.current.backgroundColor
            self.spacer.backgroundColor = Theme.current.backgroundColor
            self.backgroundView.backgroundColor = Theme.current.backgroundColor
            self.appearanceLabel.textColor = Theme.current.grays
            self.overrideThemeDesc.textColor = Theme.current.grays
            self.lightText.textColor = Theme.current.textColor
            self.darkText.textColor = Theme.current.textColor
            self.lightButton.innerCircleCircleColor = Theme.current.textColor
            self.lightButton.outerCircleColor = Theme.current.textColor
            self.darkButton.innerCircleCircleColor = Theme.current.textColor
            self.darkButton.outerCircleColor = Theme.current.textColor
            self.overrideSystemTheme.textColor = Theme.current.textColor
            self.setdarkMode()
        }
    }
    
    func setThemeOverride() {
        if themeOverrideDefaults.object(forKey: "systemTheme") as! Bool == true {
            overrideThemeToggle.isOn = true
        } else {
            overrideThemeToggle.isOn = false
            
        }
    }
    
    func setdarkMode() {
        let theme = getThemeDefault()
        if theme == "LightTheme" {
            lightButton.isSelected = true
            darkButton.isSelected = false
            setThemeDefault(state: "LightTheme")
        } else {
            lightButton.isSelected = false
            darkButton.isSelected = true
            setThemeDefault(state: "DarkTheme")
        }
    }
    
    @IBAction func lightThemePressed(_ sender: Any) {
        if lightButton.isSelected {
            return
        }
        setThemeDefault(state: "LightTheme")
        overrideThemeToggle.isOn = false
        themeOverrideDefaults.set(false, forKey: "systemTheme")
        applyThemeDefault()
        applyTheme()
        lightButton.isSelected = true
        darkButton.isSelected = false
        
    }
    
    
    @IBAction func darkThemePressed(_ sender: Any) {
        if darkButton.isSelected {
            return
        }
        setThemeDefault(state: "DarkTheme")
        overrideThemeToggle.isOn = false
        themeOverrideDefaults.set(false, forKey: "systemTheme")
        applyThemeDefault()
        applyTheme()
        lightButton.isSelected = false
        darkButton.isSelected = true
        
    }
    
    
    @IBAction func overrideSystemTheme(_ sender: Any) {
        if overrideThemeToggle.isOn {
            themeOverrideDefaults.set(true, forKey: "systemTheme")
            applyThemeDefault()
            applyTheme()
            DispatchQueue.main.async() {
                self.setdarkMode()
            }
            
            
            
        } else {
            themeOverrideDefaults.set(false, forKey: "systemTheme")
            applyThemeDefault()
            applyTheme()
            DispatchQueue.main.async() {
                self.setdarkMode()
            }
            
            
            
            
        }
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
