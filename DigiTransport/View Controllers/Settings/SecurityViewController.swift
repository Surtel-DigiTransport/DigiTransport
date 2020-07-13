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
    
    @IBOutlet weak var faceIDLabel: UILabel!
    
    @IBOutlet weak var faceIDToggle: UISwitch!
    
    @IBOutlet weak var autoLoginLabel: UILabel!
    
    @IBOutlet weak var autoLoginToggle: UISwitch!

    override func viewDidLoad() {
        setFaceID()
        setAutoLogin()
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        

        if biometryType() == 0 {
            faceIDLabel.text = "Login To App With Face ID"
        } else if biometryType() == 1 {
            faceIDLabel.text = "Login To App With Touch ID"
        } else if biometryType() == 2 {
            print(biometryType())
            faceIDLabel.text = "Biometric Login isn't available"
            faceIDToggle.isOn = false
            faceIDToggle.isEnabled = false
        }
        applyTheme()
    }
    
    func applyTheme() {
        backgroundView.backgroundColor = Theme.current.backgroundColor
        faceIDLabel.textColor = Theme.current.textColor
        autoLoginLabel.textColor = Theme.current.textColor
        
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
        FaceIDDefaults.set(true, forKey: "faceIDValue")
        } else {
            FaceIDDefaults.set(false, forKey: "faceIDValue")
        }
        
    }
    
    @IBAction func autoLoginToggleChanged(_ sender: Any) {
        let AutoLoginDefaults = UserDefaults.standard
        
        if autoLoginToggle.isOn {
            faceIDToggle.isEnabled = true
        AutoLoginDefaults.set(true, forKey: "AutoLogin")
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

