//
//  ThemeProtocol.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/28/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


// Protocol For Themes: Switches between different themes based on what is chose in Theme.swift or what the variable Theme.current is set to
protocol ThemeProtocol {
    var backgroundColor: UIColor {get}
    var altbackgroundColor: UIColor {get}
    var textColor: UIColor {get}
    var accent: UIColor {get}
    var grays: UIColor {get}
    var grayWhite: UIColor {get}
    var blackWhite: UIColor {get}
    var digitransportLogo: UIImage {get}
    var lineaccents: UIColor {get}
    var tabBarColors: UIColor {get}
    var oppositegrays: UIColor {get}
    
}
