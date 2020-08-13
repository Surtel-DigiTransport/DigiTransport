//
//  AddImageToTextField.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/2/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


// Adds images to left of text field (such as password lock for a password text field)

extension UIViewController {
    func addImagetoField(textField: UITextField, andImage image: UIImage, constant: CGFloat = 5.0) {

        let leftImageView = UIImageView(frame:CGRect(x: 0.0, y: -0.8, width: image.size.width, height: image.size.height))
        leftImageView.image = image

        let leftImageView1 = UIView(frame: CGRect(x: 0.0, y: -0.8, width: image.size.width + constant, height: image.size.height))
        leftImageView1.addSubview(leftImageView)

        textField.leftView = leftImageView1

        textField.leftViewMode = .always

    }
}
