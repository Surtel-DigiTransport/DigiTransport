//
//  HideShowPasswordFix.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/4/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField {

    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }

}
