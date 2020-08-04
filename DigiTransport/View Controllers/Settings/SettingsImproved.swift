//
//  SettingsImproved.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/16/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//


import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    var settingsCells: [SettingsController] = []
    
    var settingsValues: [String] = ["Themes", "Security"]
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        UITabBar.appearance().barTintColor = Theme.current.tabBarColors
        applyTheme()
        settingsCells = createArray()
        
    }
    
    
    @objc func applyTheme() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
        applyThemeDefault()
            self.tableView.backgroundColor = Theme.current.backgroundColor
            self.backgroundView.backgroundColor = Theme.current.backgroundColor
            self.logoutButton.setTitleColor(Theme.current.grays, for: .normal)
            UITabBar.appearance().barTintColor = Theme.current.tabBarColors
            self.tableView.reloadData()
        }
    }
    
    
    func createArray() -> [SettingsController] {
        var tempcell: [SettingsController] = []
    
        for i in  0..<settingsValues.count {
            let Cell1 = SettingsController(
                label: settingsValues[i],
                rightarrow: UIImage(systemName: "chevron.right")!
            )
            
            tempcell.append(Cell1)
            
            
        }
        return tempcell
    }
    
    @IBAction func logoutCalled(_ sender: Any) {
        try? AuthController.signOut()
    
        loginResponseDetails.message = ""
        loginResponseDetails.status = false
        loginResponseDetails.isResetFirstPassword = false
        loginResponseDetails.isFinalRegistrationSubmitted = false
        loginResponseDetails.finalStatus = ""
        loginResponseDetails.isAgreementsAccepted = false
        loginResponseDetails.carrierCountry = ""
        
        let storyboard = UIStoryboard(name: "ShamitMain", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "LoginVC")
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        self.hidesBottomBarWhenPushed = true
        }
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsCells.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = settingsCells[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        
        cell.backgroundColor = Theme.current.backgroundColor

        cell.selectionStyle = .none
        cell.setSettings(settings: settingCell)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
        goToSetting(int: indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = Theme.current.backgroundColor
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = Theme.current.backgroundColor
    }
    
    func goToSetting(int: Int = 0) {
        
        var controller: String = "Error"
        if int == 0 {controller = "ThemesVC"}
        if int == 1 {controller = "SecurityVC"}
        
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: controller)
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    
}

