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


    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var topSpacer: UIView!


    @IBOutlet weak var bottomSpacer: UIView!

    @IBOutlet weak var forgotPassword: UIButton!


    @IBOutlet weak var agreementPolicy: UILabel!

    @IBOutlet weak var poweredBy: UILabel!
    
    var userStyle = ""
    
    override func viewDidLoad() {
        print(userStyle)
        super.viewDidLoad()
        print(getFaceIDDefaults())
        if getAutoLogin() {
        if AuthController.isSignedIn {
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyThemeDefault()
        passwordField.showhidepasswordbutton()
        self.hideKeyboardWhenTappedAround()
        self.ScrollUpFromKeyboard()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    

    struct myImages {
        static let loginImage = UIImage(systemName: "person")!
        static let passwordImage = UIImage(systemName: "lock")!
        
    }


    fileprivate func applyTheme() {
        backgroundView.backgroundColor = Theme.current.backgroundColor
        topSpacer.alpha = 0.0
        bottomSpacer.backgroundColor = Theme.current.backgroundColor
        forgotPassword.backgroundColor = Theme.current.backgroundColor
        loginField.backgroundColor = Theme.current.backgroundColor
        passwordField.backgroundColor = Theme.current.backgroundColor
        poweredBy.backgroundColor = Theme.current.backgroundColor
        agreementPolicy.backgroundColor = Theme.current.backgroundColor
        forgotPassword.setTitleColor(Theme.current.grays, for:.normal)
        loginField.textColor = Theme.current.textColor
        passwordField.textColor = Theme.current.textColor
        poweredBy.textColor = Theme.current.grays
        agreementPolicy.textColor = Theme.current.grayWhite
        loginField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        passwordField.setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
        backgroundImage.image = Theme.current.digitransportLogo
       
        
    }


        
        

    
    @IBAction func loginButton(sender: UIButton) {
        loginPressed()
    }


    func loginPressed() {
        guard let email = loginField.text, email.count > 0 else {
            return
          }
          guard let password = passwordField.text, password.count > 0 else {
            return
          }
          
          let name = UIDevice.current.name
          let user = User(name: name, email: email)
          
          do {
            try AuthController.signIn(user, password: password)

            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "HomePageVC")
            self.navigationController?.pushViewController(secondVC, animated: true)
          } catch {
            print("Error signing in: \(error.localizedDescription)")
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
    
}
