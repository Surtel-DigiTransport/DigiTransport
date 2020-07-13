//
//  SpecificBackgroundColor.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/2/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit


class CustomBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.green
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let bottomRect = CGRect(
            origin: CGPoint(x: rect.origin.x, y: rect.height / 2),
            size: CGSize(width: rect.size.width, height: rect.size.height / 2)
        )
        UIColor.red.set()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.fill(bottomRect)
    }

}


