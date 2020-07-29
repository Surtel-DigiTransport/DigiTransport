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

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet var passwordField: UITextField!

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
    
var forgotPasswordpressed = false
    override func viewDidLoad() {
        
    }
    var keyboardHeight: CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        keyboardHeight = KeyboardService.keyboardHeight()
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        forgotPasswordpressed = false
        super.viewDidLoad()
        
        print("done")
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        applyThemeDefault()
        passwordField.showhidepasswordbutton()
        self.hideKeyboardWhenTappedAround()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
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
        loginField.setBottomBorder(color: UIColor.systemGray2)
        passwordField.setBottomBorder(color: UIColor.systemGray2)


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
                do {
                    let password = try KeychainPasswordItem(service: serviceName, account: currentUser!.email).readPassword()
                    getValidLogin(username: email, password: password)
                   } catch {
                     return
                   }
                
                if loginResponseDetails.message == "Login Successful" {
                    if getFaceIDDefaults() {
                    let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "HomePageVC")
                    authenticationWithBiometrics(ViewController: secondVC)
                    } else {
                        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
                        let secondVC = storyboard.instantiateViewController(identifier: "HomePageVC")
                        self.navigationController?.pushViewController(secondVC, animated: true)
                        
                    }
                }
            }
        }

    }

    
    @objc func textFieldDidChange(textfield: UITextField) {
        if !(loginField.text == loginAttemptDetails.username) || !(passwordField.text == loginAttemptDetails.password) {
            errorLabel.alpha = 0.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        if forgotPasswordpressed == false {
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    var realOrigin: CGPoint = CGPoint(x: 0,y: 0)
    var buttonHeight: CGFloat = 0.0
    
    override func viewDidLayoutSubviews() {
        realOrigin = buttonView.convert(loginButton.frame.origin, to: self.view)
        buttonHeight = view.frame.size.height - (loginButton.frame.size.height + realOrigin.y)
         if keyboardHeight > buttonHeight {
             self.ScrollUpFromKeyboard(amount: keyboardHeight - buttonHeight)
         } else {
              self.ScrollUpFromKeyboard(amount: -10)
              
         }
    }
    
  
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        forgotPasswordpressed = true
    }
    
    struct myImages {
        static let loginImage = UIImage(systemName: "person")!
        static let passwordImage = UIImage(systemName: "lock")!
        
    }


    @objc func applyTheme() {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
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
            self.loginField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
            self.passwordField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
            self.backgroundImage.image = Theme.current.digitransportLogo
        }
    }


        
        

    
    @IBAction func loginButton(sender: UIButton) {
        togglebuttontap()
        loginPressed()
    }


    func loginPressed() {
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
          
        getValidLogin(username: email, password: password)
        self.errorLabel.text = loginResponseDetails.message
        if loginResponseDetails.status == true {
            do {
                try AuthController.signIn(user, password: password)

                let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
                let secondVC = storyboard.instantiateViewController(identifier: "HomePageVC")
                self.navigationController?.pushViewController(secondVC, animated: true)
            } catch {
                print("Error signing in: \(error.localizedDescription)")
            }
        } else {
            errorLabel.alpha = 1.0
            loginField.isEnabled = true
            passwordField.isEnabled = true
            loginButton.isEnabled = true
            backButton.isEnabled = true
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
    
    
    func getValidLogin(username: String, password: String) {
        let session = URLSession.shared
        let url = URL(string: "http://sLogisticglobalapiuat.surteltechnologies.com/api/loginapi/carrierlogin")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "UserName": username,
            "Password": password
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        var done = false
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                    print("Could not cast JSON content as a Dictionary<String, Any>")
                    return
                }

                // Print result
                
                loginResponseDetails.message = dictionary["Message"] as! String
                loginResponseDetails.status = dictionary["Status"] as! Bool
                loginResponseDetails.isResetFirstPassword = dictionary["IsResetFirstPassword"] as! Bool
                loginResponseDetails.isFinalRegistrationSubmitted = dictionary["IsFinalRegistrationSubmitted"] as! Bool
                loginResponseDetails.finalStatus = dictionary["FinalStatus"] as? String ?? "nil"
                loginResponseDetails.isAgreementsAccepted = dictionary["IsAgreementsAccepted"] as! Bool
                loginResponseDetails.carrierCountry = dictionary["CarrierCountry"] as? String ?? "nil"
                
                print("message: " + loginResponseDetails.message)
                print("status: " + String(loginResponseDetails.status))
                print("isResetFirstPassword: " + String(loginResponseDetails.isResetFirstPassword))
                print("isFinalRegistrationSubmitted: " + String(loginResponseDetails.isFinalRegistrationSubmitted))
                print("finalStatus: " + loginResponseDetails.finalStatus)
                print("isAgreementsAccepted: " + String(loginResponseDetails.isAgreementsAccepted))
                print("carrierCountry: " + loginResponseDetails.carrierCountry)
                
                loginAttemptDetails.username = username
                loginAttemptDetails.password = password
                
                
                done = true
            } catch {
                // Print error if something went wrong
                print("Error: \(error)")
            }
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
        
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
    static var message: String = ""
    static var status: Bool = false
    static var isResetFirstPassword: Bool = false
    static var isFinalRegistrationSubmitted: Bool = false
    static var finalStatus: String = ""
    static var isAgreementsAccepted: Bool = false
    static var carrierCountry: String = ""
    
    
}

