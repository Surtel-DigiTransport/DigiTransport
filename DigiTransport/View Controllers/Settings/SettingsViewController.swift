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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        applyTheme()
        
        
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func applyTheme() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
        applyThemeDefault()
        UITabBar.appearance().barTintColor = Theme.current.tabBarColors
            self.backgroundView.backgroundColor = Theme.current.backgroundColor
            self.logoutButton.setTitleColor(Theme.current.grays, for:.normal)
        for i in 0..<self.collectionOfLabels.count {
            self.collectionOfLabels[i].textColor = Theme.current.textColor
        }
        for i in 0..<self.collectionOfViews.count {
            self.collectionOfViews[i].backgroundColor = Theme.current.backgroundColor
        }
        for i in 0..<self.collectionOfArrows.count {
            self.collectionOfArrows[i].tintColor = Theme.current.textColor
        }
        }
    
    }
    
    
    
    @IBAction func showThemes(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ThemesVC")
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func showSecurity(_ sender: Any) {
        
        
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
