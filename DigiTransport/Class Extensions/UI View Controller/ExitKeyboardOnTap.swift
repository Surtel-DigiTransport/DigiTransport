//
//  ExitKeyboardOnTap.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/28/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        let seconds = 0.03
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        if !getbuttontap() {
            self.view.endEditing(true)
        } else {
            togglebuttontap()
        }
        }
    }
}

var buttontap = false
func getbuttontap() -> Bool{
    return buttontap
}

public func togglebuttontap() {
    if buttontap == false {
        buttontap = true
    }
    else if buttontap == true {
        buttontap = false
    }
}
