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
    
    
    @objc func applyTheme() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            applyThemeDefault()
            self.CommunicationType.textColor = Theme.current.textColor
            self.subject.textColor = Theme.current.textColor
            self.partnerType.textColor = Theme.current.textColor
            self.partnerID.textColor = Theme.current.textColor
            self.effectiveFrom.textColor = Theme.current.textColor
            self.effectiveTo.textColor = Theme.current.textColor
            self.downtimeFrom.textColor = Theme.current.textColor
            self.downtimeTo.textColor = Theme.current.textColor
        
//        backgroundButton.backgroundColor = Theme.current.backgroundColor
        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: UIApplication.willEnterForegroundNotification, object: nil)
        applyTheme()
        
    }
    
}

