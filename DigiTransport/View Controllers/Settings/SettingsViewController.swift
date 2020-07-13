//
//  SettingsViewController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/9/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var backgroundView: UIView!
    
   @IBOutlet var collectionOfLabels: Array<UILabel>!
    
    @IBOutlet var collectionOfArrows: Array<UIImageView>!
    @IBOutlet var collectionOfViews: Array<UIView>!
    
    @IBOutlet weak var logoutButton: UIButton!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        
        
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func applyTheme() {
        backgroundView.backgroundColor = Theme.current.backgroundColor
        logoutButton.setTitleColor(Theme.current.grays, for:.normal)
        for i in 0..<collectionOfLabels.count {
        collectionOfLabels[i].textColor = Theme.current.textColor
        }
        for i in 0..<collectionOfViews.count {
        collectionOfViews[i].backgroundColor = Theme.current.backgroundColor
        }
        for i in 0..<collectionOfArrows.count {
        collectionOfArrows[i].tintColor = Theme.current.textColor
        }
        
    
    }
    @IBAction func logoutCalled(_ sender: Any) {
        try? AuthController.signOut()
        let storyboard = UIStoryboard(name: "ShamitMain", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "LoginVC")
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    @IBAction func showThemes(_ sender: Any) {
        print("test")
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ThemesVC")
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func showSecurity(_ sender: Any) {
        print("test1")
        
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SecurityVC")
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func touchDownThemes(_ sender: Any) {
        collectionOfViews[6].backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
    }
    
   
    @IBAction func touchExitThemes(_ sender: Any) {
        collectionOfViews[6].backgroundColor = Theme.current.backgroundColor
    }
    
    @IBAction func touchDownSecurity(_ sender: Any) {
         collectionOfViews[7].backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
     }
     
    
     @IBAction func touchExitSecurity(_ sender: Any) {
         collectionOfViews[7].backgroundColor = Theme.current.backgroundColor
     }
    
    
    
}
