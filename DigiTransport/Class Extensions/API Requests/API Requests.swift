//
//  API Requests.swift
//  DigiTransport
//
//  Created by Shamit Surana on 8/3/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class APIRequests {
    
    class func getValidLogin(username: String, password: String) {
        let session = URLSession.shared
        let url = URL(string: "http://sLogisticglobalapiuat.surteltechnologies.com/api/loginapi/carrierlogin")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "UserName": username,
            "Password": password
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        var done = false
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                    print("Could not cast JSON content as a Dictionary<String, Any>")
                    return
                }

                // Print result
                
                loginResponseDetails.message = dictionary["Message"] as! String
                loginResponseDetails.status = dictionary["Status"] as! Bool
                loginResponseDetails.isResetFirstPassword = dictionary["IsResetFirstPassword"] as! Bool
                loginResponseDetails.isFinalRegistrationSubmitted = dictionary["IsFinalRegistrationSubmitted"] as! Bool
                loginResponseDetails.finalStatus = dictionary["FinalStatus"] as? String ?? "nil"
                loginResponseDetails.isAgreementsAccepted = dictionary["IsAgreementsAccepted"] as! Bool
                loginResponseDetails.carrierCountry = dictionary["CarrierCountry"] as? String ?? "nil"
                
                print("message: " + loginResponseDetails.message)
                print("status: " + String(loginResponseDetails.status))
                print("isResetFirstPassword: " + String(loginResponseDetails.isResetFirstPassword))
                print("isFinalRegistrationSubmitted: " + String(loginResponseDetails.isFinalRegistrationSubmitted))
                print("finalStatus: " + loginResponseDetails.finalStatus)
                print("isAgreementsAccepted: " + String(loginResponseDetails.isAgreementsAccepted))
                print("carrierCountry: " + loginResponseDetails.carrierCountry)
                
                
                done = true
            } catch {
                // Print error if something went wrong
                print("Error: \(error)")
            }
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
        
    }
}
