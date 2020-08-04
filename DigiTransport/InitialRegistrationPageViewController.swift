//
//  ViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 6/20/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class InitialRegistrationPageViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var stateTextField: UITextField!
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    @IBOutlet weak var countryCodeCompanyFaxTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var shipperIDTextField: UITextField!
    @IBOutlet weak var carrierCompanyNameTextField: UITextField!
    @IBOutlet weak var primaryContactPersonNameTextField: UITextField!
    @IBOutlet weak var primaryContactEmailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var countryCodePrimaryPersonTextField: UITextField!
    @IBOutlet weak var countryCodePrimaryPersonMobileTextField: UITextField!
    @IBOutlet weak var companyFaxNumberTextField: UITextField!
    @IBOutlet weak var primaryContactPersonPhoneNumberTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var primaryContactPersonMobileNumberTextField: UITextField!
    var countryList:[String] = [ "Australia", "India", "United States"]
    var stateList:[String] = []
    var cityList:[String] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == countryTextField {
            return countryList.count
        }
        else if currentTextField == stateTextField {
            return stateList.count
        }
        else if currentTextField == cityTextField {
            return cityList.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == countryTextField {
            return countryList[row]
        }
        else if currentTextField == stateTextField {
            return stateList[row]
        }
        else if currentTextField == cityTextField {
            return cityList[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == countryTextField {
            countryTextField.text = countryList[row]
            self.view.endEditing(true)
        }
        else if currentTextField == stateTextField {
            stateTextField.text = stateList[row]
            self.view.endEditing(true)
        }
        else if currentTextField == cityTextField {
            cityTextField.text = stateList[row]
        }
    }
       
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        currentTextField.inputView = pickerView
    }
    
    
    func setUpElements () {
        Utilities.standardTextField(textfield: countryTextField)
        Utilities.standardTextField(textfield: stateTextField)
        Utilities.standardTextField(textfield: cityTextField)
        Utilities.standardTextField(textfield: shipperIDTextField)
        Utilities.standardTextField(textfield: carrierCompanyNameTextField)
        Utilities.standardTextField(textfield: primaryContactPersonNameTextField)
        Utilities.standardTextField(textfield: primaryContactEmailTextField)
        Utilities.standardTextField(textfield: addressTextField)
        Utilities.standardCountryCodeTextField(textfield: countryCodeCompanyFaxTextField)
        Utilities.standardCountryCodeTextField(textfield: countryCodePrimaryPersonTextField)
        Utilities.standardCountryCodeTextField(textfield: countryCodePrimaryPersonMobileTextField)
        Utilities.standardNumberTextField(textfield: companyFaxNumberTextField)
        Utilities.standardNumberTextField(textfield: primaryContactPersonPhoneNumberTextField)
        Utilities.standardNumberTextField(textfield: primaryContactPersonMobileNumberTextField)
        Utilities.standardButton(signUpButton)
    }

}

