//
//  SettingsCells.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/16/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet var backgroundcontentView: UIView!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet weak var rightArrow: UIImageView!
    
    @objc func applyTheme() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
        applyThemeDefault()
            self.label.textColor = Theme.current.textColor
            self.rightArrow.tintColor = Theme.current.textColor
        }
    }
    

    func setSettings(settings: SettingsController) {
        label.text = settings.label
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        applyTheme()
        
    }
    
}

class SettingsController {
    
    var label: String
    var rightarrow: UIImage
    
    init(
        label: String,
        rightarrow: UIImage
    ) {
        self.label = label
        self.rightarrow = rightarrow
    }
    
}
