//
//  UI Button Image on Left Text in Center.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/26/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class CustomButton : UIButton {

    @IBInspectable var alignImageToRight : Bool = false

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if(alignImageToRight){
            let imageRect = super.imageRect(forContentRect: contentRect)
            let offset = contentRect.maxX - imageRect.maxX + 10
            return imageRect.offsetBy(dx: offset, dy: 0.0)
        }
        return super.imageRect(forContentRect: contentRect)
    }
}
