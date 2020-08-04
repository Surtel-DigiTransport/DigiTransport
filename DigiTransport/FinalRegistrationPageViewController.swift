//
//  FinalRegistrationPageViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 7/4/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class FinalRegistrationPageViewController: UIViewController {
    
    @IBOutlet weak var proprietorNameTextField: UITextField!
    @IBOutlet weak var companyRegistrationNumber1TextField: UITextField!
    @IBOutlet weak var companyRegistrationNumber2TextField: UITextField!
    @IBOutlet weak var companyRegistrationNumber3TextField: UITextField!
    @IBOutlet weak var companyRegistrationNumber4TextField: UITextField!
    @IBOutlet weak var taxType1TextField: UITextField!
    @IBOutlet weak var taxNumber1TextField: UITextField!
    @IBOutlet weak var taxType2TextField: UITextField!
    @IBOutlet weak var taxNumber2TextField: UITextField!
    @IBOutlet weak var taxType3TextField: UITextField!
    @IBOutlet weak var taxNumber3TextField: UITextField!
    @IBOutlet weak var taxType4TextField: UITextField!
    @IBOutlet weak var taxNumber4TextField: UITextField!
    @IBOutlet weak var taxType5TextField: UITextField!
    @IBOutlet weak var taxNumber5TextField: UITextField!
    @IBOutlet weak var paymentAccountTypeTextField: UITextField!
    @IBOutlet weak var bankAccountNumberTextField: UITextField!
    @IBOutlet weak var bankNameTextField: UITextField!

    @IBOutlet weak var bankBranchNameTextField: UITextField!
    @IBOutlet weak var bankIFSCCodeTextField: UITextField!
    @IBOutlet weak var thirdPartyPaymentInformation1TextField: UITextField!
    @IBOutlet weak var thirdPartyPaymentInformation2TextField: UITextField!
    @IBOutlet weak var thirdPartyPaymentInformation3TextField: UITextField!
    @IBOutlet weak var thirdPartyPaymentInformation4TextField: UITextField!
    @IBOutlet weak var trailerTypeTextField: UITextField!
    @IBOutlet weak var serviceCategoriesTextField: UITextField!
    @IBOutlet weak var serviceAreaTextField: UITextField!
    @IBOutlet weak var businessTypeTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements () {
        Utilities.standardTextField(textfield: proprietorNameTextField)
        Utilities.standardTextField(textfield: companyRegistrationNumber1TextField)
        Utilities.standardTextField(textfield: companyRegistrationNumber2TextField)
        Utilities.standardTextField(textfield: companyRegistrationNumber3TextField)
        Utilities.standardTextField(textfield: companyRegistrationNumber4TextField)
        Utilities.standardTextField(textfield: taxType1TextField)
        Utilities.standardTextField(textfield: taxNumber1TextField)
        Utilities.standardTextField(textfield: taxType2TextField)
        Utilities.standardTextField(textfield: taxNumber2TextField)
        Utilities.standardTextField(textfield: taxType3TextField)
        Utilities.standardTextField(textfield: taxNumber3TextField)
        Utilities.standardTextField(textfield: taxType4TextField)
        Utilities.standardTextField(textfield: taxNumber4TextField)
        Utilities.standardTextField(textfield: taxType5TextField)
        Utilities.standardTextField(textfield: taxNumber5TextField)
        Utilities.standardTextField(textfield: paymentAccountTypeTextField)
        Utilities.standardTextField(textfield: bankAccountNumberTextField)
        Utilities.standardTextField(textfield: bankNameTextField)
        Utilities.standardTextField(textfield: bankBranchNameTextField)
        Utilities.standardTextField(textfield: bankIFSCCodeTextField)
        Utilities.standardTextField(textfield: thirdPartyPaymentInformation1TextField)
        Utilities.standardTextField(textfield: thirdPartyPaymentInformation2TextField)
        Utilities.standardTextField(textfield: thirdPartyPaymentInformation3TextField)
        Utilities.standardTextField(textfield: thirdPartyPaymentInformation4TextField)
        Utilities.standardTextField(textfield: trailerTypeTextField)
        Utilities.standardTextField(textfield: serviceCategoriesTextField)
        Utilities.standardTextField(textfield: serviceAreaTextField)
        Utilities.standardTextField(textfield: stateTextField)
        Utilities.standardTextField(textfield: businessTypeTextField)
        Utilities.standardButton(submitButton)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
