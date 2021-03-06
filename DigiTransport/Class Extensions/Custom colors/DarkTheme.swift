//
//  DarkTheme.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/28/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

// Dark Theme: Can add more variables (colors, images, etc) based on what you want for whatever theme color. These are the base ones colors throughout the app, as they dynamically adapt to the theme
class DarkTheme: ThemeProtocol {
    var altbackgroundColor: UIColor = UIColor.custom.gray.darkgray
    var backgroundColor: UIColor = UIColor.custom.background.darkgrey
    var textColor: UIColor = UIColor.white
    var accent: UIColor = UIColor.systemGray5
    var grays: UIColor = UIColor.lightGray
    var oppositegrays: UIColor = UIColor.darkGray
    var grayWhite: UIColor = UIColor.white
    var blackWhite: UIColor  = UIColor.white
    var digitransportLogo: UIImage = UIImage(named: "DigiTransportWhite")!
    var lineaccents: UIColor = UIColor.lightGray.withAlphaComponent(0.3)
    var tabBarColors: UIColor = UIColor.custom.gray.offdarkgray
 
    
}
