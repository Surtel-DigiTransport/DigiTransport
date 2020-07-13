//
//  HomeViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 6/20/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    var current = 1
    @IBOutlet weak var backgroundView: UIView!
    
    
    @IBOutlet var collectionOfButtons: [UIButton]!
    
    @IBOutlet var collectionOfTopLabels: Array<UILabel>!
    
    @IBOutlet var collectionOfBottomLabels: Array<UILabel>!
    
    @IBOutlet var collectionOfAccentLines: Array<UIView>!
    
    @IBOutlet var collectionOfViews: Array<UIView>!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        
        
        
        
//        let testButton : UIButton = UIButton.init(type: .custom)
//        testButton.setImage(UIImage(named: "settingIcon"), for: .normal)
//        testButton.addTarget(self, action: #selector(settingsView), for: .touchUpInside)
//        testButton.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
//        let addButton = UIBarButtonItem(customView: testButton)
//        self.navigationItem.setLeftBarButtonItems([addButton], animated: false)

    }


        
        
    
    func applyTheme() {
        backgroundView.backgroundColor = Theme.current.backgroundColor
        
        for i in 0..<collectionOfButtons.count {
            collectionOfButtons[i].backgroundColor = Theme.current.backgroundColor
        }
        
        for i in 0..<collectionOfAccentLines.count {
            
            collectionOfAccentLines[i].backgroundColor = Theme.current.lineaccents
        }
        
        for i in 0..<collectionOfViews.count {
            collectionOfViews[i].backgroundColor = Theme.current.backgroundColor
            
            collectionOfViews[i].layer.shadowColor = UIColor.systemGray2.cgColor
            collectionOfViews[i].layer.shadowOpacity = 0.5
            collectionOfViews[i].layer.shadowOffset = .zero
            collectionOfViews[i].layer.shadowRadius = 5
//            collectionOfViews[i].layer.shadowPath = UIBezierPath(rect: collectionOfViews[i].bounds).cgPath
        }
        for i in 0..<collectionOfTopLabels.count {
        collectionOfTopLabels[i].textColor = Theme.current.textColor
        }
        for i in 0..<collectionOfBottomLabels.count {
        collectionOfBottomLabels[i].textColor = Theme.current.grays
        }
    }
    @IBAction func goToBids(_ sender: Any) {
        print("Bids pressed")
        print(Settings.currentUser!.email)
        
        
    }
    
    @IBAction func goToDrivers(_ sender: Any) {
        print("Drivers pressed")
    }
    
    
    @IBAction func goToNotifications(_ sender: Any) {
        print("Notifications pressed")
        
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        print("Settings pressed")
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SettingsVC")
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    @IBAction func goToAgreements(_ sender: Any) {
        print("Agreements pressed")
        let storyboard = UIStoryboard(name: "CommunicationPage", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "CommunicationVC")
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    
    
}
