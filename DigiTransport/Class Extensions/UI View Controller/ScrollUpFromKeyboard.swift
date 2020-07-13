//
//  scrollupfromkeyboard.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/5/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

extension UIViewController {
    func ScrollUpFromKeyboard() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeUnActive), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 50
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
        }
    
    }
    
    @objc func applicationDidBecomeUnActive(notification: NSNotification) {
        self.view.endEditing(true)
        
    }
    
}



