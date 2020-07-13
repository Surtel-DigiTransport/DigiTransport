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
    func setBottomBorder(color: UIColor) {
    self.borderStyle = .none
    self.layer.backgroundColor = color.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
