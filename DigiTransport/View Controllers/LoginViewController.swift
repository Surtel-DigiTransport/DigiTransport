//
//  LoginViewController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/25/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//
import UIKit
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginField: UITextField!


    @IBOutlet weak var passwordField: UITextField!


    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var topSpacer: UIView!


    @IBOutlet weak var bottomSpacer: UIView!

    @IBOutlet weak var forgotPassword: UIButton!


    @IBOutlet var agreementPolicy: UILabel!

    @IBOutlet var poweredBy: UILabel!





    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        loginField.delegate = self
        loginField.tag = 0

        passwordField.delegate = self
        passwordField.tag = 1

//      SETTING BOTTOM LINE (INSTEAD OF BOX) FOR UITEXTFIELD
        loginField.setBottomBorder(color: UIColor.systemGray2)
        passwordField.setBottomBorder(color: UIColor.systemGray2)


//      ADDING IMAGES TO FIELDS
        addImagetoField(textField: loginField, andImage: (myImages.loginImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
        addImagetoField(textField: passwordField, andImage: myImages.passwordImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal))


        applyTheme()


    }


    struct myImages {
        static let loginImage = UIImage(systemName: "person")!
        static let passwordImage = UIImage(systemName: "lock")!
    }

    func addImagetoField(textField: UITextField, andImage image: UIImage) {

        let leftImageView = UIImageView(frame:CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
        leftImageView.image = image

        let leftImageView1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: image.size.width + 5, height: image.size.height))
        leftImageView1.addSubview(leftImageView)

        textField.leftView = leftImageView1

        textField.leftViewMode = .always

    }



    fileprivate func applyTheme() {
        backgroundView.backgroundColor = Theme.current.backgroundColor
        topSpacer.backgroundColor = Theme.current.backgroundColor
        bottomSpacer.backgroundColor = Theme.current.backgroundColor
        forgotPassword.backgroundColor = Theme.current.backgroundColor
        loginField.backgroundColor = Theme.current.backgroundColor
        passwordField.backgroundColor = Theme.current.backgroundColor
        poweredBy.backgroundColor = Theme.current.backgroundColor
        agreementPolicy.backgroundColor = Theme.current.backgroundColor
        forgotPassword.setTitleColor(Theme.current.grayWhite, for:.normal)
        loginField.textColor = Theme.current.textColor
        passwordField.textColor = Theme.current.textColor
        poweredBy.textColor = Theme.current.grays
        agreementPolicy.textColor = Theme.current.grayWhite
        loginField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        passwordField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        if Theme.current.textColor == UIColor.black {
            if isDarkStatusBar == false {
            isDarkStatusBar.toggle()
            }
        }
        if Theme.current.textColor == UIColor.white {
            if isDarkStatusBar == true {
            isDarkStatusBar.toggle()
            }
        }

        }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkStatusBar ? .darkContent : .lightContent

    }

    var isDarkStatusBar = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    @IBAction func loginButton(sender: UIButton) {
        loginPressed()
    }


    func loginPressed() {
        let login = loginField.text
        let password = passwordField.text
        if login == "shamit" {
            if password == "dark" {
                Theme.current = DarkTheme()
                passwordField.text = "light"
            }
            if password == "light" {
                Theme.current = LightTheme()
                passwordField.text = "dark"

            }

        }
        applyTheme()


    }


     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         // Try to find next responder
         if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            // Not found, so remove keyboard.
            loginPressed()
         }
         // Do not add a line break
         return false
      }

}
