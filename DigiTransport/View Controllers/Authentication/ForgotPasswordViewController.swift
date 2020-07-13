//
//  ForgotPassword.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/1/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet var forgotPasswordTextField: UITextField!
    
    @IBOutlet weak var forgotPasswordFieldTwo: UITextField!
    
    @IBOutlet var forgotpasswordButton: UIButton!
    
    @IBOutlet weak var bottomSpacer: UIView!
    
    @IBOutlet weak var topSpacer: UIView!
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var resendCodeLabel: UIButton!
    
    @IBOutlet weak var backToLoginButton: UIButton!
    
    var screenNumber = 1
    struct myImages {
        static let personImage = UIImage(systemName: "person")!
        static let inputImage = UIImage(systemName: "circle.grid.3x3.fill")!
        static let passwordImage = UIImage(systemName: "lock")!
        static let confirmPasswordImage = UIImage(systemName: "lock.rotation")!
    }
    
    fileprivate func runMain() {
        
        forgotPasswordTextField.setBottomBorder(color: UIColor.systemGray2)
        forgotPasswordFieldTwo.setBottomBorder(color: UIColor.systemGray2)
        forgotPasswordTextField.delegate = self
        forgotPasswordTextField.tag = 0


        
        
        if screenNumber == 1 {
            forgotPasswordTextField.isSecureTextEntry = false
            forgotPasswordFieldTwo.isHidden = true
            resendCodeLabel.alpha = 0.0
            forgotPasswordTextField.returnKeyType = UIReturnKeyType.go
            messageLabel.text = "Enter your User ID to receive a code to reset your password."
            forgotPasswordTextField.placeholder = "Enter registered user id"
            forgotpasswordButton.setTitle("Submit UserID", for: .normal)
            addImagetoField(textField: forgotPasswordTextField, andImage: (myImages.personImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
            
            
            applyTheme()
            
        } else if screenNumber == 2 {
            forgotPasswordTextField.text = ""
            messageLabel.text = "If an account exists, a reset code was sent to you."
            resendCodeLabel.alpha = 1.0
            messageLabel.alpha = 1.0
            forgotPasswordTextField.placeholder = "Input your reset code here"
            forgotpasswordButton.setTitle("Submit code", for: .normal)
            
            addImagetoField(textField: forgotPasswordTextField, andImage: (myImages.inputImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
            
            applyTheme()
            
            
        } else if screenNumber == 3 {
            self.ScrollUpFromKeyboard()
            forgotPasswordTextField.isSecureTextEntry = true
            forgotPasswordFieldTwo.isSecureTextEntry = true
            forgotPasswordTextField.showhidepasswordbutton()
            forgotPasswordFieldTwo.showhidepasswordbutton()
            forgotPasswordFieldTwo.delegate = self
            forgotPasswordFieldTwo.tag = 1
            forgotPasswordTextField.text = ""
            resendCodeLabel.alpha = 0.0
            messageLabel.text = "Please enter your new credentials"
            forgotPasswordTextField.returnKeyType = UIReturnKeyType.next
            forgotPasswordTextField.placeholder = "Enter new Password"
            forgotPasswordFieldTwo.placeholder = "Confirm your password"
            forgotPasswordFieldTwo.isHidden = false
            forgotpasswordButton.setTitle("Submit New Password", for: .normal)
            
            addImagetoField(textField: forgotPasswordTextField, andImage: (myImages.passwordImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
            addImagetoField(textField: forgotPasswordFieldTwo, andImage: (myImages.confirmPasswordImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
            
            applyTheme()
            
        } else {
            backToLoginButton.isEnabled = false
            resendCodeLabel.isEnabled = false
            forgotPasswordTextField.isEnabled = false
            forgotPasswordFieldTwo.isEnabled = false
            forgotpasswordButton.isEnabled = false
            messageLabel.text = "Success! Redirecting to the Login Page..."
            messageLabel.alpha = 1.0
            forgotPasswordFieldTwo.isEnabled = false
            let seconds = 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.backToLogin()
            }

        }
    }
    
    func sendResetLink() {
        print("sent reset link")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        runMain()
        
        
    }
    
    fileprivate func backToLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         // Try to find next responder
         if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            // Not found, so remove keyboard.
             textField.resignFirstResponder()
            infoAuthentication()
         }
         // Do not add a line break
         return false
      }
    
    @IBAction func backButton(_ sender: Any) {
        backToLogin()
        
    }
    
    @IBAction func loginreturnButton(_ sender: Any) {
        backToLogin()
    }
    
    fileprivate func infoAuthentication() {
        var goToNextPage = false
        if screenNumber == 1 {

            goToNextPage = true
        }
        else if screenNumber == 2 {
            
            goToNextPage = true
        }
        else if screenNumber == 3 {
            goToNextPage = true
        }
        if goToNextPage == true {
            
            screenNumber = screenNumber + 1
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.runMain()
            }, completion: nil)
        } else {
            screenNumber = screenNumber + 1
            runMain()
        }
        
    }
    @IBAction func forgotpasswordButton(_ sender: Any) {
        infoAuthentication()
    }
    
    fileprivate func applyTheme() {

        backToLoginButton.backgroundColor = Theme.current.backgroundColor
        messageLabel.backgroundColor = Theme.current.backgroundColor
        resendCodeLabel.backgroundColor = Theme.current.backgroundColor
        backgroundView.backgroundColor = Theme.current.backgroundColor
        forgotPasswordTextField.backgroundColor = Theme.current.backgroundColor
        forgotPasswordFieldTwo.backgroundColor = Theme.current.backgroundColor
        bottomSpacer.backgroundColor = Theme.current.backgroundColor
        topSpacer.alpha = 0.0
        forgotPasswordFieldTwo.backgroundColor = Theme.current.backgroundColor
        forgotPasswordTextField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        forgotPasswordFieldTwo.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        forgotPasswordTextField.textColor = Theme.current.textColor
        forgotPasswordFieldTwo.textColor = Theme.current.textColor
        messageLabel.textColor = Theme.current.textColor
        resendCodeLabel.setTitleColor(Theme.current.grays, for:.normal)
        backToLoginButton.setTitleColor(Theme.current.grays, for:.normal)
        backgroundImage.image = Theme.current.digitransportLogo
//        forgotPasswordTextField
//        forgotpasswordButton
//        bottomSpacer
//        topSpacer
            
        }
}

