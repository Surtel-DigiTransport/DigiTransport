//
//  CommunicationCell.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class CommunicationCell: UITableViewCell {
    
    @IBOutlet var backgroundcontentView: UIView!
    
    @IBOutlet weak var CommunicationType: UILabel!
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var partnerType: UILabel!
    @IBOutlet weak var partnerID: UILabel!
    @IBOutlet weak var effectiveFrom: UILabel!
    @IBOutlet weak var effectiveTo: UILabel!
    @IBOutlet weak var downtimeFrom: UILabel!
    @IBOutlet weak var downtimeTo: UILabel!
    
//    @IBOutlet weak var backgroundButton: UIButton!
    
    @IBOutlet var collectionOfCommunicationLabels: Array<UILabel>!
    
    
    func applyTheme() {
        for i in 0..<collectionOfCommunicationLabels.count {
        collectionOfCommunicationLabels[i].textColor = Theme.current.textColor
//            collectionOfCommunicationLabels[i].backgroundColor = Theme.current.backgroundColor
        }
//        backgroundcontentView.backgroundColor = Theme.current.backgroundColor
        CommunicationType.textColor = Theme.current.textColor
        subject.textColor = Theme.current.textColor
        partnerType.textColor = Theme.current.textColor
        partnerID.textColor = Theme.current.textColor
        effectiveFrom.textColor = Theme.current.textColor
        effectiveTo.textColor = Theme.current.textColor
        downtimeFrom.textColor = Theme.current.textColor
        downtimeTo.textColor = Theme.current.textColor
//        backgroundButton.backgroundColor = Theme.current.backgroundColor
        
    }
    

    
    func setCommunication(communication: Communication) {
        CommunicationType.text = communication.communicationType
        subject.text = communication.subject
        partnerType.text = communication.partnerType
        partnerID.text = communication.partnerID
        effectiveFrom.text = communication.effectiveFrom
        effectiveTo.text = communication.effectiveTo
        downtimeFrom.text = communication.downtimeFrom
        downtimeTo.text = communication.downtimeTo
        applyTheme()
        
    }
    
}


//extension ViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: indexPath) {
//        print("tapped")
//    }
//}
//
//extension ViewController: UITableViewDataSource {
//    number
//
//}




//override func numberOfSections(in tableView: UITableView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    return 0
//}
//
//override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of rows
//    return 0
//}
