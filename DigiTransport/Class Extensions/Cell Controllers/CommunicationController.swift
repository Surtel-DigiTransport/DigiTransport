//
//  CommunicationController.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class Communication {
    
    var communicationType: String
    var subject: String
    var partnerType: String
    var partnerID: String
    var effectiveFrom: String
    var effectiveTo: String
    var downtimeFrom: String
    var downtimeTo: String
    
    init(
        communicationType: String,
        subject: String,
        partnerType: String,
        partnerID: String,
        effectiveFrom: String,
        effectiveTo: String,
        downtimeFrom: String,
        downtimeTo: String
    
    
    ) {
        self.communicationType = communicationType
        
        self.subject = subject
            
        self.partnerType = partnerType
        
        self.partnerID = partnerID
        
        self.effectiveFrom = effectiveFrom
        
        self.effectiveTo = effectiveTo
        
        self.downtimeFrom = downtimeFrom
        
        self.downtimeTo = downtimeTo
        
    }
    
    
}
