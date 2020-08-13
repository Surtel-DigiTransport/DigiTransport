//
//  bidCell.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 7/9/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import Foundation
import UIKit

class BidCell: UITableViewCell {
    
    @IBOutlet weak var bidID: UILabel!
  
    @IBOutlet weak var bidTItle: UILabel!

    @IBOutlet weak var bidStatus: UILabel!
    @IBOutlet weak var shipperName: UILabel!
    @IBOutlet weak var noOfBidders: UILabel!
    @IBOutlet weak var bidStartDate: UILabel!
    @IBOutlet weak var bidEndDate: UILabel!

    @IBOutlet weak var locationThru: UILabel!
    @IBOutlet weak var locationFrom: UILabel!
    @IBOutlet weak var specialNote: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.origin.x = 4
            frame.size.width -= 2 * 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
}
