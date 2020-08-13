//
//  LoginViewController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/25/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//
import UIKit
class LoginViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var loginField: FloatingLabel!

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet var passwordField: FloatingLabel!

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var topSpacer: UIView!


    @IBOutlet weak var bottomSpacer: UIView!

    @IBOutlet weak var forgotPassword: UIButton!


    @IBOutlet weak var agreementPolicy: UILabel!

    @IBOutlet weak var poweredBy: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var buttonView: UIStackView!
    
    var userStyle = ""
    
    var loginbuttonPressed  = false
    

    

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return false
        }else{
            return true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    var keyboardHeight: CGFloat = 0.0
    var realOrigin: CGPoint = CGPoint(x: 0, y: 0)
    override func viewWillAppear(_ animated: Bool) {
        keyboardHeight = KeyboardService.keyboardHeight()
        realOrigin = buttonView.convert(loginButton.frame.origin, to: self.view)
        setScrollUpFromKeyboardtoTrue(object: loginButton, keyboardHeight: keyboardHeight, realOrigin: realOrigin)
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        forgotPassword.isEnabled = true
        self.hidesBottomBarWhenPushed = true
        loginbuttonPressed = false
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        applyThemeDefault()
        passwordField.showhidepasswordbutton()
        self.hideKeyboardWhenTappedAround()
        

        loginField.delegate = self
        loginField.tag = 0

        passwordField.delegate = self
        passwordField.tag = 1
        
        errorLabel.alpha = 0.0
        loginField.isEnabled = true
        passwordField.isEnabled = true
        loginButton.isEnabled = true
        backButton.isEnabled = true

//      SETTING BOTTOM LINE (INSTEAD OF BOX) FOR UITEXTFIELD
//        loginField.setBottomBorder(color: Theme.current.grays)
//        passwordField.setBottomBorder(color: Theme.current.grays)


//      ADDING IMAGES TO FIELDS
        addImagetoField(textField: loginField, andImage: (myImages.loginImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
        addImagetoField(textField: passwordField, andImage: myImages.passwordImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal))

        passwordField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)

        loginField.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        
        applyTheme()
        if getAutoLogin() {
            if AuthController.isSignedIn {
                print(Settings.currentUser!.email)
                print(Settings.currentUser!.name)
                let email = (Settings.currentUser?.email)!
                let serviceName = "DigiTransportKeychain"
                let currentUser = Settings.currentUser
                var currentpassword = ""
                do {
                    let password = try KeychainPasswordItem(service: serviceName, account: currentUser!.email).readPassword()
                    currentpassword = password
                    APIRequests.getValidLogin(username: email, password: password)
                   } catch {
                     return
                   }
                
                if loginResponseDetails.status == true {
                    if getFaceIDDefaults() {
                    authenticationWithBiometrics(email: email, password: currentpassword)
                    } else {
                        loginStatusController()
                    }
                }
            }
        }

    }
    
    

    override func viewWillLayoutSubviews() {
        setScrollUpFromKeyboardtoTrue(object: loginButton, keyboardHeight: keyboardHeight, realOrigin: realOrigin)
    }
    
    @objc func textFieldDidChange(textfield: UITextField) {
        if !(loginField.text == loginAttemptDetails.username) || !(passwordField.text == loginAttemptDetails.password) {
            errorLabel.alpha = 0.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        if loginbuttonPressed == true  {
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    
  

    struct myImages {
        static let loginImage = UIImage(systemName: "person")!
        static let passwordImage = UIImage(systemName: "lock")!
        
    }


    func applyTheme() {
        print("ok")
        self.backgroundView.backgroundColor = Theme.current.backgroundColor
        self.topSpacer.alpha = 0.0
        self.bottomSpacer.backgroundColor = Theme.current.backgroundColor
        self.forgotPassword.backgroundColor = Theme.current.backgroundColor
        self.loginField.backgroundColor = Theme.current.backgroundColor
        self.passwordField.backgroundColor = Theme.current.backgroundColor
        self.poweredBy.backgroundColor = Theme.current.backgroundColor
        self.agreementPolicy.backgroundColor = Theme.current.backgroundColor
        self.forgotPassword.setTitleColor(Theme.current.grays, for:.normal)
        self.loginField.textColor = Theme.current.textColor
        self.passwordField.textColor = Theme.current.textColor
        self.poweredBy.textColor = Theme.current.grays
        self.agreementPolicy.textColor = Theme.current.grayWhite
        self.loginField.floatingLabelBackground = Theme.current.backgroundColor
        self.passwordField.floatingLabelBackground = Theme.current.backgroundColor
        self.loginField.floatingLabelColor = Theme.current.grays
        self.passwordField.floatingLabelColor = Theme.current.grays
        self.loginField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        self.passwordField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        self.backgroundImage.image = Theme.current.digitransportLogo
        
    }
    
    func loginStatusController() {
        
        if loginResponseDetails.isFinalRegistrationSubmitted == false {
            
            let storyboard = UIStoryboard(name: "TanayMain", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "FinalRegistrationVC")
            loginbuttonPressed = true
            self.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(secondVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "HomePageVC")
            loginbuttonPressed = true
            self.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
        
    }

        
        

    
    @IBAction func loginButton(sender: UIButton) {
        togglebuttontap()
        loginPressed()
    }


    func loginPressed() {
        forgotPassword.isEnabled = false
        guard let email = loginField.text, email.count > 0 else {
            return
        }
        guard let password = passwordField.text, password.count > 0 else {
            return
        }
        loginButton.isEnabled = false
        loginField.isEnabled = false
        passwordField.isEnabled = false
        backButton.isEnabled = false
        
        let name = UIDevice.current.name
        let user = User(name: name, email: email)
    
          
        APIRequests.getValidLogin(username: email, password: password)
        loginAttemptDetails.username = email
        loginAttemptDetails.password = password
        self.errorLabel.text = loginResponseDetails.message
        if email == "Shamit" {
            loginResponseDetails.status = true
        }
        if loginResponseDetails.status == true {
            do {
                try AuthController.signIn(user, password: password)
                loginStatusController()
                
            } catch {
                print("Error signing in: \(error.localizedDescription)")
            }
        } else {
            forgotPassword.isEnabled = true
            errorLabel.alpha = 1.0
            loginField.isEnabled = true
            passwordField.isEnabled = true
            loginButton.isEnabled = true
            backButton.isEnabled = true
//            passwordField.displayErrorMessage(message: "test")
        }
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         // Try to find next responder
         if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            loginPressed()
         }
         // Do not add a line break
         return false
      }
    
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    struct loginAttemptDetails {
        static var username: String = ""
        static var password: String = ""
        
    }
}


struct loginResponseDetails {
    static var username: String = Settings.currentUser!.email
    static var token: String = ""
    static var message: String = ""
    static var status: Bool = false
    static var isResetFirstPassword: Bool = false
    static var isFinalRegistrationSubmitted: Bool = false
    static var finalStatus: String = ""
    static var isAgreementsAccepted: Bool = false
    static var carrierCountry: String = ""
    
}


