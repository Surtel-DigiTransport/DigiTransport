//
//  Theme Defaults.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/8/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

let ThemeDefaults = UserDefaults.standard

func setThemeDefault(state: String = "LightTheme") {
    ThemeDefaults.set(state, forKey: "ThemeDefaults")
}

func getThemeDefault() -> String{
    if ThemeDefaults.object(forKey:"ThemeDefaults") as? String == nil {
        ThemeDefaults.set("LightTheme", forKey: "ThemeDefaults")
    }
    return ThemeDefaults.object(forKey:"ThemeDefaults") as! String
}

func applyThemeDefault() {

    if getThemeDefault() == "LightTheme" {
        Theme.current = LightTheme()
    }

    if getThemeDefault() == "DarkTheme" {
        Theme.current = DarkTheme()
    }
    
}




