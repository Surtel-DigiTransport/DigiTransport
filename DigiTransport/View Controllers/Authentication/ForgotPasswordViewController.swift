//
//  ForgotPassword.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/1/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet var forgotPasswordTextField: UITextField!
    
    @IBOutlet weak var forgotPasswordFieldTwo: UITextField!
    
    @IBOutlet var forgotpasswordButton: UIButton!
    
    @IBOutlet weak var bottomSpacer: UIView!
    @IBOutlet weak var forgotPasswordButtonView: UIStackView!
    
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
        
//        forgotPasswordTextField.setBottomBorder(color: Theme.current.grays)
//        forgotPasswordFieldTwo.setBottomBorder(color: Theme.current.grays)
        forgotPasswordTextField.delegate = self
        forgotPasswordTextField.tag = 0


        
        
        if screenNumber == 1 {
            forgotPasswordTextField.isSecureTextEntry = false
            forgotPasswordFieldTwo.isHidden = true
            resendCodeLabel.alpha = 0.0
            forgotPasswordTextField.returnKeyType = UIReturnKeyType.go
            messageLabel.text = NSLocalizedString("Enter your User ID to receive a code to reset your password.", comment: "")
            forgotPasswordTextField.placeholder = "Enter registered user id"
            forgotpasswordButton.setTitle("Submit UserID", for: .normal)
            addImagetoField(textField: forgotPasswordTextField, andImage: (myImages.personImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
            
            
            applyTheme()
            
        } else if screenNumber == 2 {
            forgotPasswordTextField.text = ""
            messageLabel.text = NSLocalizedString("If an account exists, a reset code was sent to you.", comment: "")
            resendCodeLabel.alpha = 1.0
            messageLabel.alpha = 1.0
            forgotPasswordTextField.placeholder = "Input your reset code here"
            forgotpasswordButton.setTitle("Submit code", for: .normal)
            
            addImagetoField(textField: forgotPasswordTextField, andImage: (myImages.inputImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
            
            applyTheme()
            
            
        } else if screenNumber == 3 {
            forgotPasswordTextField.isSecureTextEntry = true
            forgotPasswordFieldTwo.isSecureTextEntry = true
            forgotPasswordTextField.showhidepasswordbutton()
            forgotPasswordFieldTwo.showhidepasswordbutton()
            forgotPasswordFieldTwo.delegate = self
            forgotPasswordFieldTwo.tag = 1
            forgotPasswordTextField.text = ""
            resendCodeLabel.alpha = 0.0
            messageLabel.text = NSLocalizedString("Please enter your new credentials", comment: "")
            forgotPasswordTextField.returnKeyType = UIReturnKeyType.next
            forgotPasswordTextField.placeholder = NSLocalizedString("Enter new Password", comment: "")
            forgotPasswordFieldTwo.placeholder = NSLocalizedString("Confirm your password", comment: "")
            forgotPasswordFieldTwo.isHidden = false
            forgotpasswordButton.setTitle(NSLocalizedString("Submit New Password", comment: ""), for: .normal)
            
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
        runMain()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    var scrollfeature = false
    
    var keyboardHeight: CGFloat = 0.0
    var realOrigin: CGPoint = CGPoint(x: 0, y: 0)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        self.forgotPasswordTextField.isEnabled = true
        self.forgotPasswordFieldTwo.isEnabled = true
        scrollfeature = true
        keyboardHeight = KeyboardService.keyboardHeight()
        realOrigin = forgotPasswordButtonView.convert(forgotpasswordButton.frame.origin, to: self.view)
        setScrollUpFromKeyboardtoTrue(object: forgotpasswordButton, keyboardHeight: keyboardHeight, realOrigin: realOrigin)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    

    override func viewWillLayoutSubviews() {
        setScrollUpFromKeyboardtoTrue(object: forgotpasswordButton, keyboardHeight: keyboardHeight, realOrigin: realOrigin)
       }
    
    fileprivate func backToLogin() {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.forgotPasswordTextField.isEnabled = false
        self.forgotPasswordFieldTwo.isEnabled = false
        scrollfeature = false
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
    
    
    // Enter in Bussiness logic
    // Go to next page is true or false based on response from api
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
    
    @objc func applyTheme() {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.backToLoginButton.backgroundColor = Theme.current.backgroundColor
            self.messageLabel.backgroundColor = Theme.current.backgroundColor
            self.resendCodeLabel.backgroundColor = Theme.current.backgroundColor
            self.backgroundView.backgroundColor = Theme.current.backgroundColor
            self.forgotPasswordTextField.backgroundColor = Theme.current.backgroundColor
            self.forgotPasswordFieldTwo.backgroundColor = Theme.current.backgroundColor
            self.bottomSpacer.backgroundColor = Theme.current.backgroundColor
            self.topSpacer.alpha = 0.0
            self.forgotPasswordFieldTwo.backgroundColor = Theme.current.backgroundColor
            self.forgotPasswordTextField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
            self.forgotPasswordFieldTwo.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
            self.forgotPasswordTextField.textColor = Theme.current.textColor
            self.forgotPasswordFieldTwo.textColor = Theme.current.textColor
            self.messageLabel.textColor = Theme.current.textColor
            self.resendCodeLabel.setTitleColor(Theme.current.grays, for:.normal)
            self.backToLoginButton.setTitleColor(Theme.current.grays, for:.normal)
            self.backgroundImage.image = Theme.current.digitransportLogo
//        forgotPasswordTextField
//        forgotpasswordButton
//        bottomSpacer
//        topSpacer
        }
        }
}

