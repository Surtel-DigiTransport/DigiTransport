//
//  Single Line (instead of box) Text Field.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/26/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

//extension UITextField {}


extension UITextField {
    func setBottomBorder(color: UIColor, offset: CGFloat = 40) {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - offset, height: 1)
//        border.bounds = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: 1)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        
        
  }
}
