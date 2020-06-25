//
//  LoginViewController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 6/25/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bottomLine = CALayer()
        let bottomLine1 = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: loginField.frame.height - 10, width: loginField.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemGray2.cgColor
        
        bottomLine1.frame = CGRect(x: 0, y: passwordField.frame.height - 10, width: passwordField.frame.width, height: 2)
        
        bottomLine1.backgroundColor = UIColor.systemGray2.cgColor
    
        loginField.borderStyle = .none
        
        
        loginField.layer.addSublayer(bottomLine)

        passwordField.borderStyle = .none
        passwordField.layer.addSublayer(bottomLine1)
        
        
        addImagetoField(textField: loginField, andImage: (myImages.loginImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal)))
        addImagetoField(textField: passwordField, andImage: myImages.passwordImage.withTintColor(UIColor.custom.red.maroon, renderingMode: .alwaysOriginal))
    
        
        
        
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
        
        
        
        
}



