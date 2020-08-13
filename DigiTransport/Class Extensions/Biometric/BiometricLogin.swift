//
//  BiometricLogin.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/9/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit
import LocalAuthentication

extension UIViewController {
    func authenticationWithBiometrics(email: String, password: String) {
    let localAuthenticationContext = LAContext()
    localAuthenticationContext.localizedFallbackTitle = "Please enter your username/password instead"

    var authorizationError: NSError?
    let reason = "Login Authentication Failed"

    if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
            if success {
                DispatchQueue.main.async() {
                    self.navigationController?.setNavigationBarHidden(self.navigationController?.isNavigationBarHidden == false, animated: true)
                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    if loginResponseDetails.isFinalRegistrationSubmitted == false {

                        
                        let storyboard = UIStoryboard(name: "TanayMain", bundle: nil)
                        let secondVC = storyboard.instantiateViewController(identifier: "FinalRegistrationVC")
                        self.hidesBottomBarWhenPushed = false
                        self.navigationController?.pushViewController(secondVC, animated: true)
                    } else {
                        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
                        let secondVC = storyboard.instantiateViewController(identifier: "HomePageVC")
                        self.hidesBottomBarWhenPushed = false
                        self.navigationController?.pushViewController(secondVC, animated: true)
                    }
                }
                
            } else {
                // Failed to authenticate
                guard let error = evaluateError else {
                    return
                }
                print(error)
                APIRequests.getValidLogin(username: email, password: password)
            
            }
        }
    } else {
        guard let error = authorizationError else {
            return
        }
        print(error)
        APIRequests.getValidLogin(username: email, password: password)
    }
}
}

var biometryvalue = -1

func biometryType() -> Int {
    let context = LAContext()

    if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil)) {
            if (context.biometryType == LABiometryType.faceID) {
                return 0
            } else if (context.biometryType == LABiometryType.touchID) {
                return 1
            } else {
                return 2
            }
        
    }
    if (context.biometryType == LABiometryType.faceID) {
        biometryvalue = 0
    } else if (context.biometryType == LABiometryType.touchID) {
        biometryvalue = 1
    }
    return 3
}

func getbiometryValueType() -> Int{
    return biometryvalue
}
