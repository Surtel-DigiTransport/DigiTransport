//
//  BidDetailViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 7/22/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class BidDetailViewController: UIViewController {

    var count = 0
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var submitBidButton: UIButton!
    @IBOutlet weak var submitVehicleDetailsButton: UIButton!
    @IBOutlet weak var editVehicleDetailsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements() {
        Utilities.standardButton(submitBidButton)
        Utilities.standardButton(submitVehicleDetailsButton)
        Utilities.standardButton(editVehicleDetailsButton)
    }
    
    @IBAction func checkboxAction(_ sender: UIButton) {
        if sender.isSelected == true {
            
            sender.isSelected = false
            
        } else {
            
            sender.isSelected = true
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
