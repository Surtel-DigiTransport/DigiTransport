//
//  scrollupfromkeyboard.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/5/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

extension UIViewController {

    
    private func scrollUpKeyboard(object: UIView, keyboardHeight: CGFloat, realOrigin: CGPoint) {
        let buttonHeight = self.view.frame.size.height - (object.frame.size.height + realOrigin.y)
        if keyboardHeight > buttonHeight {
            self.ScrollUpFromKeyboard(amount: keyboardHeight - buttonHeight + 10)
        } else {
             self.ScrollUpFromKeyboard(amount: 0)
             
        }
        
        
    }
    
    private func ScrollUpFromKeyboard(amount: CGFloat) {
        placement.amount = amount
    }
    
    func setScrollUpFromKeyboardtoTrue(object: UIView, keyboardHeight: CGFloat, realOrigin: CGPoint) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeUnActive), name: UIApplication.willResignActiveNotification, object: nil)
        scrollUpKeyboard(object: object, keyboardHeight: keyboardHeight, realOrigin: realOrigin)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                
                self.view.frame.origin.y -= placement.amount
            
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
    
    struct placement {
        static var amount: CGFloat = 0.0
    }
}
