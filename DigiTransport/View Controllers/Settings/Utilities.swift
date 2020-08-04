//
//  Utilities.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 6/25/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func standardTextField ( textfield:UITextField) {
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.borderStyle = .line
        textfield.layer.borderColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
        textfield.layer.borderWidth = 5
    }
    
    static func standardCountryCodeTextField ( textfield:UITextField) {
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.placeholder = "Country Code"
        
        let topBorder = UIView()
        topBorder.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        topBorder.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        topBorder.frame = CGRect(x: 0, y: 0, width: textfield.frame.width, height: 5)
        textfield.addSubview(topBorder)
        
        let bottomBorder = UIView()
        bottomBorder.frame = CGRect(x: 0, y: textfield.frame.height, width: textfield.frame.width, height: 5)
        bottomBorder.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        bottomBorder.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        textfield.addSubview(bottomBorder)
        
        let leftBorder = UIView()
        leftBorder.frame = CGRect(x: 0, y: 0, width: 5, height: textfield.frame.height)
        leftBorder.autoresizingMask = [ .flexibleBottomMargin]
        leftBorder.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        textfield.addSubview(leftBorder)
        
        let underline = UIView()
        underline.frame = CGRect(x: 5, y: textfield.frame.height - 5, width: textfield.frame.width - 10, height: 1)
        underline.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        underline.backgroundColor = UIColor.init(red: 150.0/255, green: 150.0/255, blue: 150.0/255, alpha: 1)
        textfield.addSubview(underline)
        
        textfield.borderStyle = .none
        
    }
    
    static func standardNumberTextField ( textfield:UITextField) {
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        textfield.leftViewMode = .always
        
        let topBorder = UIView()
        topBorder.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        topBorder.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        topBorder.frame = CGRect(x: 0, y: 0, width: textfield.frame.width, height: 5)
        textfield.addSubview(topBorder)
        
        let bottomBorder = UIView()
        bottomBorder.frame = CGRect(x: 0, y: textfield.frame.height, width: textfield.frame.width, height: 5)
        bottomBorder.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        bottomBorder.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        textfield.addSubview(bottomBorder)
        
        let rightBorder = UIView()
        rightBorder.frame = CGRect(x: textfield.frame.width - 5, y: 0, width: 5, height: textfield.frame.height)
        rightBorder.autoresizingMask = [ .flexibleLeftMargin, .flexibleBottomMargin]
        rightBorder.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        textfield.addSubview(rightBorder)
        
        let underline = UIView()
        underline.frame = CGRect(x: 5, y: textfield.frame.height - 5, width: textfield.frame.width - 10, height: 1)
        underline.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        underline.backgroundColor = UIColor.init(red: 150.0/255, green: 150.0/255, blue: 150.0/255, alpha: 1)
        textfield.addSubview(underline)
        
        
        textfield.borderStyle = .none
        
        
    }
    
    
    static func addTransparentView (textField: UITextField, tableView: UITableView, transparentView: UIView, view: UIView, point: CGPoint, height: CGFloat) {
        textField.isUserInteractionEnabled = false
        transparentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(transparentView)
        tableView.frame = CGRect(origin: point, size: textField.frame.size)
        tableView.layer.frame.size.height = 0
        view.addSubview(tableView)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.layer.cornerRadius = 5
        tableView.reloadData()
        transparentView.alpha = 0
        var origin = CGPoint(x: 0, y: 0)
        if (view.frame.height - point.y < 210 + textField.frame.height) {
            origin.y = point.y - 210
            origin.x = point.x
        } else {
            origin.y = point.y + textField.frame.height + 10
            origin.x = point.x
        }
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            transparentView.alpha = 0.5
            tableView.frame = CGRect(origin: origin, size: textField.frame.size)
            tableView.layer.frame.size.height = height
        }, completion: nil)
    }

    
    static func standardButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 169/255, blue: 0/255, alpha: 1)
        button.layer.cornerRadius = 15.0
    }

}
extension String {
var isValidEmail: Bool {
   let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+//.[A-Za-z]{2,64}"
   let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
   return testEmail.evaluate(with: self)
    }
}

