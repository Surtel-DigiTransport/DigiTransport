//
//  Security.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class SecurityViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var faceIDLabel: UIButton!
    
    @IBOutlet weak var faceIDToggle: UISwitch!
    
    @IBOutlet weak var autoLoginLabel: UILabel!
    
    @IBOutlet weak var autoLoginToggle: UISwitch!

    override func viewWillAppear(_ animated: Bool) { 
        setFaceID()
        setAutoLogin()
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        applyTheme()
        let FaceIDDefaults = UserDefaults.standard
        if biometryType() == 0 {
         
            faceIDLabel.setTitle("Login To App With Face ID", for: .normal)
            faceIDLabel.isUserInteractionEnabled = false
        } else if biometryType() == 1 {
            faceIDLabel.setTitle("Login To App With Touch ID", for: .normal)
            faceIDLabel.isUserInteractionEnabled = false
        } else if biometryType() == 2 {
            faceIDLabel.setTitle("Biometric Login isn't available", for: .normal)
            faceIDToggle.isOn = false
            faceIDToggle.isEnabled = false
            faceIDLabel.isUserInteractionEnabled = false
            FaceIDDefaults.set(false, forKey: "faceIDValue")
        } else if biometryType() == 3 {
            FaceIDDefaults.set(false, forKey: "faceIDValue")
            faceIDLabel.setTitleColor(UIColor.custom.blue.buttonblue, for:.normal)
            if getbiometryValueType() == 0 {
            faceIDLabel.setTitle("Allow access to Face ID", for: .normal)
            } else if getbiometryValueType() == 1 {
            faceIDLabel.setTitle("Allow access to Touch ID", for: .normal)
            }
            
            self.faceIDLabel.isUserInteractionEnabled = true
            faceIDLabel.addTarget(self, action: #selector(self.goToSettings(_:)), for: .touchUpInside)
            faceIDToggle.isOn = false
            faceIDToggle.isEnabled = false
        }
    }
    
    @objc func applyTheme() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
        applyThemeDefault()
            self.backgroundView.backgroundColor = Theme.current.backgroundColor
            self.faceIDLabel.setTitleColor(Theme.current.textColor, for:.normal)
            self.faceIDLabel.setTitleColor(UIColor.custom.blue.buttonblue.withAlphaComponent(0.2), for:.selected)
            self.autoLoginLabel.textColor = Theme.current.textColor
        }
    }
    func setFaceID() {
        let FaceIDDefaults = UserDefaults.standard
        if getFaceIDDefaults() {
            if getAutoLogin() {
            faceIDToggle.isEnabled = true
            faceIDToggle.isOn = true
            FaceIDDefaults.set(true, forKey: "faceIDValue")
            } else {
                faceIDToggle.isOn = false
                faceIDToggle.isEnabled = false
                FaceIDDefaults.set(false, forKey: "faceIDValue")
            }
        } else {
            faceIDToggle.isOn = false
            if !getAutoLogin() {
                faceIDToggle.isEnabled = false
                FaceIDDefaults.set(false, forKey: "faceIDValue")
            }
        }
        
    }
    
    func setAutoLogin() {
        if getAutoLogin() {
            autoLoginToggle.isOn = true
        } else {
            autoLoginToggle.isOn = false
        }
    }
    
    @IBAction func faceIDToggleChanged(_ sender: Any) {
        let FaceIDDefaults = UserDefaults.standard
        if faceIDToggle.isOn {
            if getAutoLogin() {
                faceIDToggle.isEnabled = true
                faceIDToggle.isOn = true
                FaceIDDefaults.set(true, forKey: "faceIDValue")
            } else {
                faceIDToggle.isEnabled = false
                faceIDToggle.isOn = false
                FaceIDDefaults.set(false, forKey: "faceIDValue")
            }
        } else {
            faceIDToggle.isEnabled = false
            faceIDToggle.isOn = false
            FaceIDDefaults.set(false, forKey: "faceIDValue")
        }
        
    }
    
    @IBAction func autoLoginToggleChanged(_ sender: Any) {
        let AutoLoginDefaults = UserDefaults.standard
        
        if autoLoginToggle.isOn {
            AutoLoginDefaults.set(true, forKey: "AutoLogin")
            if biometryType() == 0 || biometryType() == 1 {
                faceIDToggle.isEnabled = true
            }
        } else {
            faceIDToggle.isOn = false
            faceIDToggle.isEnabled = false
            AutoLoginDefaults.set(false, forKey: "faceIDValue")
            AutoLoginDefaults.set(false, forKey: "AutoLogin")
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToSettings(_ sender: Any) {
       
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in // Prints true
            })
        }
    }
}


func getFaceIDDefaults() -> Bool {
    let FaceIDDefaults = UserDefaults.standard
    if FaceIDDefaults.object(forKey: "faceIDValue") == nil {
        FaceIDDefaults.set(false, forKey: "faceIDValue")
    }
    return FaceIDDefaults.object(forKey: "faceIDValue") as! Bool
    
    
    
}

func getAutoLogin() -> Bool {
    let AutoLoginDefaults = UserDefaults.standard
    if AutoLoginDefaults.object(forKey: "AutoLogin") == nil {
        AutoLoginDefaults.set(false, forKey: "AutoLogin")
    }
    return AutoLoginDefaults.object(forKey: "AutoLogin") as! Bool
    
}

