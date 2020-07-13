//
//  AddImageToTextField.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/2/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


extension UIViewController {
    func addImagetoField(textField: UITextField, andImage image: UIImage) {

        let leftImageView = UIImageView(frame:CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
        leftImageView.image = image

        let leftImageView1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: image.size.width + 5, height: image.size.height))
        leftImageView1.addSubview(leftImageView)

        textField.leftView = leftImageView1

        textField.leftViewMode = .always

    }
}
