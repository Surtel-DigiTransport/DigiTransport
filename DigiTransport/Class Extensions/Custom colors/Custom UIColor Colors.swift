//
//  Custom UIColor Colors.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/25/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

extension UIColor {
   struct custom {
        struct orange {
            static let lightorange = UIColor(netHex: 0xffa900)
            static let darkorange = UIColor(netHex: 0xff9800)
        }

        struct red {
            static let maroon = UIColor(netHex: 0x800000)

        }
        struct background {
            static let lightpink = UIColor(netHex: 0xf2e2e3)
            static let darkgrey = UIColor(netHex: 0x111111)
            
        }
    
        struct gray {
            static let darkgray = UIColor(netHex: 0x0f0f0f)
            static let offdarkgray = UIColor(netHex: 0x080808)
            static let offwhite = UIColor(netHex: 0xfafafa)
            static let placeholderLight = UIColor(netHex: 0xc7c7c7)
            static let placeholderDark = UIColor(netHex: 0xc7c7c7)
        }
        
        struct blue {
            static let buttonblue = UIColor(netHex: 0x3092ea)
        }
    }
    
}
