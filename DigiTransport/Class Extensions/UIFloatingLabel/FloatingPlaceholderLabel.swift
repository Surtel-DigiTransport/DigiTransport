//
//  FloatingPlaceholderLabel.swift
//  DigiTransport
//
//  Created by Shamit Surana on 8/6/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class FloatingLabel: UITextField {
    var displayStatus: Bool!
    var floatingLabel: UILabel!// = UILabel(frame: CGRect.zero)
    var floatingLabelHeight: CGFloat = 14
    var button = UIButton(type: .custom)
    var imageView = UIImageView(frame: CGRect.zero)
    var singleLineInputResponse: Bool!
    var temperrortext: String!
    var errorLabelDisplayed: Bool!
    
    @IBInspectable
    var _placeholder: String?
    
    @IBInspectable
    var floatingLabelColor: UIColor = Theme.current.grays {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    var activeFloatingLabelColor: UIColor = UIColor.orange {
        didSet {
            self.floatingLabel.textColor = activeFloatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.blue
    
    @IBInspectable
    var floatingLabelBackground: UIColor = Theme.current.backgroundColor {
        didSet {
            self.floatingLabel.backgroundColor = self.floatingLabelBackground
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 8) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var singleLineInput: Bool = true {
        didSet {
            self.singleLineInputResponse = self.singleLineInput
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var _backgroundColor: UIColor = Theme.current.backgroundColor {
        didSet {
            self.layer.backgroundColor = self._backgroundColor.cgColor
        }
    }
    
    func displayErrorMessage(message: String, options: String = "nil") {
        // options: persistant: Text Field won't remove error message when user edits the field
        // notFullDisplay: When there is no text in field (empty) the error message won't display (the floating lable will act like normal)
        
        errorLabelDisplayed = true
        temperrortext = self.text
        self.floatingLabel.text = message
        self.floatingLabel.textColor = UIColor.red
        if self.singleLineInputResponse == true {
            if self.isFirstResponder {
                self.setBottomBorder(color: UIColor.red, offset: 0)
            }
        }
        if options != "persistant" {
            self.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        }
        if options != "notFullDisplay" {
            displayStatus = true
        }
        
    }
    
    func removeErrorMessage() {
        if self.isFirstResponder {
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.textColor = activeFloatingLabelColor
            errorLabelDisplayed = false
        } else {
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.textColor = floatingLabelColor
            errorLabelDisplayed = false
        }
    }
    
    @objc func textFieldDidChange(textfield: UITextField) {
        if textfield.text != temperrortext {
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.textColor = activeFloatingLabelColor
            self.setBottomBorder(color: activeFloatingLabelColor, offset: 0)
            errorLabelDisplayed = false
            displayStatus = false
            self.removeTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        }
    }
   
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.singleLineInputResponse = self.singleLineInput
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        self.floatingLabel = UILabel(frame: CGRect.zero)
        placeholder = self._placeholder // Make sure the placeholder is shown
        createFloatingLabel()
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
        self.addTarget(self, action: #selector(self.colorFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeColorFloatingLabel), for: .editingDidEnd)
        
    }
    
    @objc func colorFloatingLabel() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
            if self.errorLabelDisplayed != true {
                self.floatingLabel.textColor = self.activeFloatingLabelColor
                if self.singleLineInputResponse == true {
                    self.setBottomBorder(color: self.activeFloatingLabelColor, offset: 0)
                }
            } else {
                self.floatingLabel.textColor = UIColor.red
                if self.singleLineInputResponse == true {
                    self.setBottomBorder(color: UIColor.red, offset: 0)
                }
            }
            self.setNeedsLayout()
        })
    }
        
    
    @objc func removeColorFloatingLabel() {
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
         if self.errorLabelDisplayed != true {
            self.floatingLabel.textColor = self.floatingLabelColor
            if self.singleLineInputResponse == true {
                self.setBottomBorder(color: self.floatingLabelColor, offset: 0)
                }
                
         } else {
            self.floatingLabel.textColor = UIColor.red
            if self.singleLineInputResponse == true {
                self.setBottomBorder(color: self.floatingLabelColor, offset: 0)
            }
        }
        }
        self.setNeedsLayout()
//        })
        
    }
    
    override public var text: String? {
        didSet {
            createFloatingLabel()
        }
    }
    
    func createFloatingLabel() {
        self.floatingLabel.textColor = self.floatingLabelColor
        self.floatingLabel.font = self.floatingLabelFont
        self.floatingLabel.text = self._placeholder
        self.floatingLabel.layer.backgroundColor = self.floatingLabelBackground.cgColor
        self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.floatingLabel.clipsToBounds = true
        self.floatingLabel.textAlignment = .center
        self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.floatingLabel.frame.width, height: self.floatingLabel.frame.height)
        self.layer.borderColor = self.activeBorderColor.cgColor
        self.addSubview(self.floatingLabel)
        self.floatingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(self.frame.height)).isActive = true
        if self.text == "" {
            self.floatingLabel.alpha = 0.0
        } else {
            self.floatingLabel.alpha = 1.0
            self.placeholder = ""
            self.bringSubviewToFront(subviews.last!)
            self.setNeedsDisplay()
        }
        
        if singleLineInputResponse == true {
            self.setBottomBorder(color: floatingLabelColor, offset: 0)
        }
        removeColorFloatingLabel()
    }
    
    // Add a floating label to the view on becoming first responder
    @objc func addFloatingLabel() {
        if self.text == "" {
//            DispatchQueue.main.async {
//                let startPoint = CGPoint(x: 40, y: 10)
//                let endPoint = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y)
//                print(self.floatingLabel.frame.origin.x)
//                print(self.floatingLabel.frame.origin.y)
//
//                let thePath = CGMutablePath()
//                thePath.move(to: CGPoint(x: startPoint.x, y: startPoint.y), transform: .identity)
//                thePath.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y), transform: .identity)
//
//                let animation = CAKeyframeAnimation(keyPath: "position")
//                animation.duration = 3.0
//                animation.path = thePath
//                animation.repeatCount = 0
//                self.floatingLabel.layer.add(animation, forKey: "position")
//            }
            
            self.floatingLabel.layer.backgroundColor = Theme.current.backgroundColor.cgColor
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .transitionCurlUp, animations: {
                
                self.floatingLabel.alpha = 1.0
                self.placeholder = ""
                
            })
        }
        
        self.bringSubviewToFront(subviews.last!)
        self.setNeedsDisplay()
        // Floating label may be stuck behind text input. we bring it forward as it was the last item added to the view heirachy
        
    }
    
    @objc func removeFloatingLabel() {
        if displayStatus != true {
            if self.text == "" {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCurlDown, animations: {
                    self.floatingLabel.alpha = 0.0
                    self.setNeedsDisplay()
                })
                self.placeholder = self._placeholder
            }
            self.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func addViewPasswordButton() {
        self.button.setImage(UIImage(named: "ic_reveal"), for: .normal)
        self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.button.frame = CGRect(x: 0, y: 16, width: 22, height: 16)
        self.button.clipsToBounds = true
        self.rightView = self.button
        self.rightViewMode = .always
        self.button.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
    }
    
    func addImage(image: UIImage){
        
        self.imageView.image = image
        self.imageView.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.leftView = self.imageView
            self.leftViewMode = .always
        }
        
    }
    
    @objc func enablePasswordVisibilityToggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            self.button.setImage(UIImage(named: "ic_show"), for: .normal)
        }else{
            self.button.setImage(UIImage(named: "ic_hide"), for: .normal)
        }
    }
}
