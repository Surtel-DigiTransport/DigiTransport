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

                loginResponseDetails.token = dictionary["Token"] as? String ?? ""
                loginResponseDetails.message = dictionary["Message"] as! String
                loginResponseDetails.status = dictionary["Status"] as! Bool
                loginResponseDetails.isResetFirstPassword = dictionary["IsResetFirstPassword"] as! Bool
                loginResponseDetails.isFinalRegistrationSubmitted = dictionary["IsFinalRegistrationSubmitted"] as! Bool
                loginResponseDetails.finalStatus = dictionary["FinalStatus"] as? String ?? "nil"
                loginResponseDetails.isAgreementsAccepted = dictionary["IsAgreementsAccepted"] as! Bool
                loginResponseDetails.carrierCountry = dictionary["CarrierCountry"] as? String ?? "nil"
                
                print("token: " + loginResponseDetails.token)
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
    
    
    class func setFinalRegistrationDetails(username: String = loginResponseDetails.username, token: String = loginResponseDetails.token) {
        let session = URLSession.shared
        let url = URL(string: ("http://sLogisticglobalapiuat.surteltechnologies.com/api/registrationapi/GetCarrier?CarrierUserName=" + username))!
        
        print(username)
        print(token)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue(loginResponseDetails.token, forHTTPHeaderField: "Token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var done = false
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                   print("Error took place \(error)")
                   return
               }
            
//            if let response = response as? HTTPURLResponse {
//                   print("Response HTTP Status code: \(response.statusCode)")
//               }
            
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                    print("Could not cast JSON content as a Dictionary<String, Any>")
                    return
                }
                print(dictionary)
                finalRegistrationDetailResponse.CarrierID = dictionary["CarrierID"] as? String
                finalRegistrationDetailResponse.CarrierCompanyName = dictionary["CarrierCompanyName"] as? String
                finalRegistrationDetailResponse.ProprietorName = dictionary["ProprietorName"] as? String
                finalRegistrationDetailResponse.PrimaryContactPersonMobileNumber = dictionary["PrimaryContactPersonMobileNumber"] as? String
                finalRegistrationDetailResponse.CarrierCompanyPhoneNumber = dictionary["CarrierCompanyPhoneNumber"] as? String
                finalRegistrationDetailResponse.PANNumber = dictionary["PANNumber"] as? String
                finalRegistrationDetailResponse.BankAccountNumber = dictionary["BankAccountNumber"] as? String
                finalRegistrationDetailResponse.BankIFSCCode = dictionary["BankIFSCCode"] as? String
                finalRegistrationDetailResponse.BankName = dictionary["BankName"] as? String
                finalRegistrationDetailResponse.BankBranchName = dictionary["BankBranchName"] as? String
                finalRegistrationDetailResponse.PrimaryContactEmail = dictionary["PrimaryContactEmail"] as? String
                finalRegistrationDetailResponse.AddressLine1 = dictionary["AddressLine1"] as? String
                finalRegistrationDetailResponse.AddressLine2 = dictionary["AddressLine2"] as? String
                finalRegistrationDetailResponse.ZipCode = dictionary["ZipCode"] as? String
                finalRegistrationDetailResponse.CountryCode = dictionary["CountryCode"] as? String
                finalRegistrationDetailResponse.CityName = dictionary["CityName"] as? String
                finalRegistrationDetailResponse.StateName = dictionary["StateName"] as? String
                finalRegistrationDetailResponse.BusinessTypeID = dictionary["BusinessTypeID"] as? String
                finalRegistrationDetailResponse.BusinessTypeList = dictionary["BusinessTypeList"] as! NSArray
                finalRegistrationDetailResponse.CarrierUserName = dictionary["CarrierUserName"] as? String
                finalRegistrationDetailResponse.CarrierCompanyFaxNumber = dictionary["CarrierCompanyFaxNumber"] as? String
                finalRegistrationDetailResponse.PrimaryContactPersonName = dictionary["PrimaryContactPersonName"] as? String
                finalRegistrationDetailResponse.PrimaryContactPersonPhoneNumber = dictionary["PrimaryContactPersonPhoneNumber"] as? String
                finalRegistrationDetailResponse.CompanyRegistrationNumber_Text1 = dictionary["CompanyRegistrationNumber_Text1"] as? String
                finalRegistrationDetailResponse.CompanyRegistrationNumber_Value1 = dictionary["CompanyRegistrationNumber_Value1"] as? String
                finalRegistrationDetailResponse.CompanyRegistrationNumber_Text2 = dictionary["CompanyRegistrationNumber_Text2"] as? String
                finalRegistrationDetailResponse.CompanyRegistrationNumber_Value2 = dictionary["CompanyRegistrationNumber_Value2"] as? String
                finalRegistrationDetailResponse.TaxType1 = dictionary["TaxType1"] as? String
                finalRegistrationDetailResponse.TaxNumber1 = dictionary["TaxNumber1"] as? String
                finalRegistrationDetailResponse.TaxType2 = dictionary["TaxType2"] as? String
                finalRegistrationDetailResponse.TaxNumber2 = dictionary["TaxNumber2"] as? String
                finalRegistrationDetailResponse.TaxType3 = dictionary["TaxType3"] as? String
                finalRegistrationDetailResponse.TaxNumber3 = dictionary["TaxNumber3"] as? String
                finalRegistrationDetailResponse.TaxType4 = dictionary["TaxType4"] as? String
                finalRegistrationDetailResponse.TaxNumber4 = dictionary["TaxNumber4"] as? String
                finalRegistrationDetailResponse.PaymentAccountType = dictionary["PaymentAccountType"] as? String
                finalRegistrationDetailResponse.PaymentTypes = dictionary["PaymentTypes"] as? String
                finalRegistrationDetailResponse.ThirdPartyPaymentInformation1 = dictionary["ThirdPartyPaymentInformation1"] as? String
                finalRegistrationDetailResponse.ThirdPartyPaymentInformation2 = dictionary["ThirdPartyPaymentInformation2"] as? String
                finalRegistrationDetailResponse.ThirdPartyPaymentInformation3 = dictionary["ThirdPartyPaymentInformation3"] as? String
                finalRegistrationDetailResponse.ThirdPartyPaymentInformation4 = dictionary["ThirdPartyPaymentInformation4"] as? String
                finalRegistrationDetailResponse.ServiceCategoriesCSV = dictionary["ServiceCategoriesCSV"] as? String
                finalRegistrationDetailResponse.ServiceCategory_Other = dictionary["ServiceCategory_Other"] as? String
                finalRegistrationDetailResponse.ServiceCategoryList = dictionary["ServiceCategoryList"] as! NSArray
                finalRegistrationDetailResponse.TrailerTypesCSV = dictionary["TrailerTypesCSV"] as? String
                finalRegistrationDetailResponse.TrailerType_Other = dictionary["TrailerType_Other"] as? String
                finalRegistrationDetailResponse.TrailerTypeList = dictionary["TrailerTypeList"] as! NSArray
                finalRegistrationDetailResponse.ServiceAreas_NationWide = dictionary["ServiceAreas_NationWide"] as? String
                finalRegistrationDetailResponse.ServiceAreas_SpecificArea = dictionary["ServiceAreas_SpecificArea"] as? String
                finalRegistrationDetailResponse.DeliverToCitiesCSV = dictionary["DeliverToCitiesCSV"] as? String
                finalRegistrationDetailResponse.DeliverToStatesCSV = dictionary["DeliverToStatesCSV"] as? String
                finalRegistrationDetailResponse.StateList = dictionary["StateList"] as! NSArray
                finalRegistrationDetailResponse.CallType = dictionary["CallType"] as? String
                
                done = true
            } catch {
                // Print error if something went wrong
                print("Error: \(error)")
                fatalError()
            }
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
    }
    
    struct finalRegistrationDetailResponse {
        static var CarrierID: String? = nil
        static var CarrierCompanyName: String? = nil
        static var ProprietorName: String? = nil
        static var PrimaryContactPersonMobileNumber: String? = nil
        static var CarrierCompanyPhoneNumber: String? = nil
        static var PANNumber: String? = nil
        static var BankAccountNumber: String? = nil
        static var BankIFSCCode: String? = nil
        static var BankName: String? = nil
        static var BankBranchName: String? = nil
        static var PrimaryContactEmail: String? = nil
        static var AddressLine1: String? = nil
        static var AddressLine2: String? = nil
        static var ZipCode: String? = nil
        static var CountryCode: String? = nil
        static var CityName: String? = nil
        static var StateName: String? = nil
        static var BusinessTypeID: String? = nil
        static var BusinessTypeList: NSArray = []
        static var CarrierUserName: String? = nil
        static var CarrierCompanyFaxNumber: String? = nil
        static var PrimaryContactPersonName: String? = nil
        static var PrimaryContactPersonPhoneNumber: String? = nil
        static var CompanyRegistrationNumber_Text1: String? = nil
        static var CompanyRegistrationNumber_Value1: String? = nil
        static var CompanyRegistrationNumber_Text2: String? = nil
        static var CompanyRegistrationNumber_Value2: String? = nil
        static var TaxType1: String? = nil
        static var TaxNumber1: String? = nil
        static var TaxType2: String? = nil
        static var TaxNumber2: String? = nil
        static var TaxType3: String? = nil
        static var TaxNumber3: String? = nil
        static var TaxType4: String? = nil
        static var TaxNumber4: String? = nil
        static var PaymentAccountType: String? = nil
        static var PaymentTypes: String? = nil
        static var ThirdPartyPaymentInformation1: String? = nil
        static var ThirdPartyPaymentInformation2: String? = nil
        static var ThirdPartyPaymentInformation3: String? = nil
        static var ThirdPartyPaymentInformation4: String? = nil
        static var ServiceCategoriesCSV: String? = nil
        static var ServiceCategory_Other: String? = nil
        static var ServiceCategoryList: NSArray = []
        static var TrailerTypesCSV: String? = nil
        static var TrailerType_Other: String? = nil
        static var TrailerTypeList: NSArray = []
        static var ServiceAreas_NationWide: String? = nil
        static var ServiceAreas_SpecificArea: String? = nil
        static var DeliverToCitiesCSV: String? = nil
        static var DeliverToStatesCSV: String? = nil
        static var StateList: NSArray = []
        static var CallType: String? = nil
}
    
    class func getBidList(username: String = loginResponseDetails.username, token: String = loginResponseDetails.token) -> [String: Any] {
            let session = URLSession.shared
            let url = URL(string: ("http://sLogisticglobalapiuat.surteltechnologies.com/api/bidapi/BidList?CarrierUserName=" + username))!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            request.setValue(token, forHTTPHeaderField: "Token")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            var done = false
        
            var responses: [String: Any] = [:]
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                       print("Error took place \(error)")
                       return
                   }
                
    //            if let response = response as? HTTPURLResponse {
    //                   print("Response HTTP Status code: \(response.statusCode)")
    //               }
                
                
                do {
                    guard let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                        print("Could not cast JSON content as a Dictionary<String, Any>")
                        
                        return
                    }
                    print(dictionary)
                    
                    responses = dictionary
                    
                    
                    done = true
                } catch {
                    // Print error if something went wrong
                    print("Error: \(error)")
                    fatalError()
                }
            }
            task.resume()
            repeat {
                RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
            } while !done
        
            return responses
        }
}
