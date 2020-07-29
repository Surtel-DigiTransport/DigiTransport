//
//  HomeViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 6/20/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class HomePageTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var sb = UIStoryboard(name: "SettingsImproved", bundle: nil)
        guard let tab1VC = sb.instantiateInitialViewController() else {
            fatalError("Could not load Settings VC!")
        }
        guard let tab1Icon = UIImage(named: "settings") else {
            fatalError("Could not load settignsTabIcon image!")
        }
        tab1VC.tabBarItem = UITabBarItem(title: "Settings", image: tab1Icon, selectedImage: tab1Icon)

        sb = UIStoryboard(name: "CommunicationPage", bundle: nil)
        guard let tab2VC = sb.instantiateInitialViewController() else {
            fatalError("Could not load Communication VC!")
        }
        guard let tab2Icon = UIImage(named: "communication") else {
            fatalError("Could not load communicationTabIcon image!")
        }
        tab2VC.tabBarItem = UITabBarItem(title: "Communication", image: tab2Icon, selectedImage: tab2Icon)

        // etc for your other 3 tabs
        
        let viewControllerList = [ tab1VC, tab2VC ]
        viewControllers = viewControllerList
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        UITabBar.appearance().barTintColor = Theme.current.tabBarColors
    }
}
    
