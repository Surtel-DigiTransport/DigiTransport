//
//  CommunicationDetails.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


class CommunicationDetailsViewController: UIViewController {

    var passthroughstring:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
