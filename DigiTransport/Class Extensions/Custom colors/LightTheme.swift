//
//  LightTheme.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/28/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


// Light Theme: Can add more variables (colors, images, etc) based on what you want for whatever theme color. These are the base ones colors throughout the app, as they dynamically adapt to the theme
class LightTheme: ThemeProtocol {
    var altbackgroundColor: UIColor = UIColor.custom.background.lightpink
    var backgroundColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor.black
    var accent: UIColor = UIColor.custom.red.maroon
    var grays: UIColor = UIColor.darkGray
    var grayWhite: UIColor  = UIColor.darkGray
    var blackWhite: UIColor  = UIColor.black
    var digitransportLogo: UIImage = UIImage(named: "DigiTransportMaroon")!
    var lineaccents: UIColor = UIColor.lightGray.withAlphaComponent(0.3)
    var tabBarColors: UIColor = UIColor.custom.gray.offwhite
    var oppositegrays: UIColor = UIColor.lightGray
    
}
