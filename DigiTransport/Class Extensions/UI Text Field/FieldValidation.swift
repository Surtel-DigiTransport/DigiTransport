//
//  FieldValidation.swift
//  DigiTransport
//
//  Created by Shamit Surana on 8/11/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

extension String {
    func phoneNumberValidation(pattern:String = "(###) ###-####", replacmentCharacter:Character = "#") -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(encodedOffset: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
