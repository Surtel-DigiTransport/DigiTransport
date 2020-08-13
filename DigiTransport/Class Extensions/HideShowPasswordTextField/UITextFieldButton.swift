//
//  UITextFieldButton.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/4/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

extension UITextField {
    func showhidepasswordbutton(image: UIImage = UIImage(systemName: "eye")!) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refreshforshowhide), for: .touchUpInside)
        button.tintColor = .darkGray
        self.rightView = button
        self.rightViewMode = .always
        
        
    }
    
    @IBAction func refreshforshowhide(_ sender: Any) {
        togglebuttontap()
        if self.isSecureTextEntry == true {
            self.becomeFirstResponder()
            self.togglePasswordVisibility()
            showhidepasswordbutton(image: UIImage(systemName: "eye.slash")!)
            
        } else if self.isSecureTextEntry == false {
            self.becomeFirstResponder()
            self.togglePasswordVisibility()
            showhidepasswordbutton(image: UIImage(systemName: "eye")!)
            
        }
        
    }
    func togglePasswordVisibility() {
        self.clearsOnBeginEditing = false;

        isSecureTextEntry.toggle()
        
    }
    
}
