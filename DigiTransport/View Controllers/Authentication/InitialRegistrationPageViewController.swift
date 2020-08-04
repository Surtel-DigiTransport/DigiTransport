//
//  ViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 6/20/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

struct countryStruct: Decodable {
    let CountryId: Int
    let CountryName: String
}

struct stateAndCityStruct: Decodable {
    let CityName: String
    let StateName: String
    let Status: Bool
    let Message: String
}

struct initialRegistrationResponse: Decodable {
    let Status: Bool
    let Message: String
}

struct initialRegistrationDetails: Encodable {
    let CarrierCompanyName: String
    let CarrierCompanyPhoneNumber: String
    let PrimaryContactPersonName: String
    let PrimaryContactPersonPhoneNumber: String
    let PrimaryContactPersonMobileNumber: String
    let PrimaryContactEmail: String
    let AddressLine1: String
    let AdressLine2: String
    let CountryId: Int
    let StateName: String
    let CityName: String
    let ZipCode: String
    let ShipperCode: String
}

class InitialRegistrationPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    var activeTextField = UITextField()
    var countryDetails = [countryStruct]()
    var countryId = Int()
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedTextField = UITextField()
    var dataSource = [String]()
    var p = CGPoint()
    var errorName = String()
    var fieldsArray = [UITextField]()
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryCodeCompanyFaxTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(dropdownCell.self, forCellReuseIdentifier: "Cell")
        getCountries()
        stateTextField.isUserInteractionEnabled = false
        cityTextField.isUserInteractionEnabled = false
        countryCodeCompanyFaxTextField.isUserInteractionEnabled = false
        countryCodePrimaryPersonTextField.isUserInteractionEnabled = false
        countryCodePrimaryPersonMobileTextField.isUserInteractionEnabled = false
        shipperIDTextField.delegate = self
        carrierCompanyNameTextField.delegate = self
        companyFaxNumberTextField.delegate = self
        primaryContactPersonPhoneNumberTextField.delegate = self
        primaryContactPersonMobileNumberTextField.delegate = self
        addressTextField.delegate = self
        addressLine2TextField.delegate = self
        primaryContactPersonNameTextField.delegate = self
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardDidShow(notification:)),
        name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardDidHide(notification:)),
        name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideKeyboardWhenTappedAround()
    }

    func alert (title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    

    //MARK: Methods to manage keybaord
    @objc func keyboardDidShow(notification: NSNotification) {
        let info = notification.userInfo
        let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    }

    @objc func keyboardDidHide(notification: NSNotification) {
        UIScrollView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.scrollView.contentInset = UIEdgeInsets.zero
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if validateFields == true {
            return true
        }
        else {
            return false
        }
    }
    func getCountries () {
        let url = URL(string: "http://sLogisticglobalapiuat.surteltechnologies.com/api/registrationapi/GetCountries")!
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            do {
                let dataStruct = try
                JSONDecoder().decode([countryStruct].self, from: data)
                self.countryDetails = dataStruct
                var i = 0
                        repeat {
                           let countryName = dataStruct[i].CountryName
                           self.dataSource.append(countryName)
                           i += 1
                       } while (i < dataStruct.count)
            } catch {
                print(err)
            }
        }.resume()
    }
    @objc func removeTransparentView() {
        let frames = selectedTextField.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: self.p.y, width: frames.width, height: 0)
        }, completion: nil)
    }
    @objc func applyTheme() {
         fieldsArray = [carrierCompanyNameTextField, addressTextField, stateTextField, zipCodeTextField, countryTextField, cityTextField, countryCodeCompanyFaxTextField, countryCodePrimaryPersonTextField, countryCodePrimaryPersonMobileTextField, shipperIDTextField, companyFaxNumberTextField,primaryContactEmailTextField, primaryContactPersonNameTextField, primaryContactPersonPhoneNumberTextField, primaryContactPersonMobileNumberTextField, addressLine2TextField]
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.MainView.backgroundColor = Theme.current.backgroundColor
            self.scrollView.backgroundColor = Theme.current.backgroundColor
            self.signUpButton.backgroundColor = Theme.current.backgroundColor
            var i = 0
            repeat {
                self.fieldsArray[i].backgroundColor = Theme.current.backgroundColor
                self.fieldsArray[i].textColor = Theme.current.textColor
                self.fieldsArray[i].setValue(Theme.current.grays, forKeyPath: "placeholderLabel.textColor")
                i += 1
            } while (i < self.fieldsArray.count)
        }
    }
    
    @IBAction func onClickSelectCountry(_ sender: Any) {
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = countryTextField
        self.p = self.scrollView.convert(self.countryTextField.frame.origin, to: self.view.inputView)
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        selectedTextField.isUserInteractionEnabled = true
    }
    @IBAction func emailValidation(_ sender: UITextField) {
        if (sender.text!.isValidEmail == false) {
            alert(title: "Invalid Email Id", message: "Please enter a valid Email Id")
            sender.becomeFirstResponder()
        }

    }
    
    @IBAction func minCharacters(_ sender: UITextField) {
        var minLength = Int()
        var fieldName = String()
        var message = String()
        if sender == shipperIDTextField {
            minLength = 10
            fieldName = "Shipper ID"
        }
        if sender == carrierCompanyNameTextField  {
            minLength = 6
            fieldName = "Carrier Company Name"
        }
        if sender == primaryContactPersonNameTextField {
            minLength = 6
            fieldName = "Primary Contact Person Name"
        }
        if sender == companyFaxNumberTextField  {
            minLength = 10
            fieldName = "Company Fax Number"
            
        }
        if sender == primaryContactPersonMobileNumberTextField{
            minLength = 10
            fieldName = "Primary Contact Person Mobile Number"
        }
        if sender == primaryContactPersonPhoneNumberTextField {
            minLength = 8
            fieldName = "Primary Contact Person Phone Number"
        }
        if sender == addressTextField  {
            minLength = 10
            fieldName = "Address Line 1"
        }
        if sender == addressLine2TextField {
            if addressLine2TextField.text!.isEmpty == false {
                minLength = 10
                fieldName = "Address Line 2"
            } else {
                minLength = 0
            }
        }
        if sender == shipperIDTextField {
            message = fieldName + " should contain exactly " + String(minLength) + " characters"
        } else if sender == addressLine2TextField {
            message = fieldName + " should contain minimum " + String(minLength) + " characters if it is not blank"
        } else {
            message = fieldName + " should contain minimum " + String(minLength) + " characters"
        }
        if (sender.text!.count < minLength) {
                self.alert(title: fieldName, message: message)
            sender.becomeFirstResponder()
        }
    }
    
    func getStateAndCityName(CountryId: Int, zipCode: String) {
        let url = URL(string: "http://sLogisticglobalapiuat.surteltechnologies.com/api/registrationapi/GetStateCitybyZipCodeCountryId?CountryId=" + String(CountryId) + "&Zipcode=" + zipCode)!
            
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let dataStruct = try
                    JSONDecoder().decode(stateAndCityStruct.self, from: data)
                    DispatchQueue.main.async {
                        if dataStruct.Status == true {
                            self.stateTextField.text = dataStruct.StateName
                            self.cityTextField.text = dataStruct.CityName
                        } else {
                            if self.countryTextField.text?.isEmpty == true {
                                self.alert(title: "Enter Country", message: "Select a country to enter the zip code")
                            } else {
                            self.alert(title: "Invalid Zip Code", message: dataStruct.Message)
                            }
                        }
                    }
                } catch {
                    print(err)
                }
            }.resume()
    }


    @IBAction func onEnteringZipCode(_ sender: Any) {
        getStateAndCityName(CountryId: countryId, zipCode: zipCodeTextField.text!)
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTextField.text = dataSource[indexPath.row]
        countryId = countryDetails[indexPath.row].CountryId
        if countryId == countryDetails[0].CountryId {
            countryCodePrimaryPersonMobileTextField.text = "+91"
            countryCodePrimaryPersonTextField.text = "+91"
            countryCodeCompanyFaxTextField.text = "+91"
        } else if countryId == countryDetails[1].CountryId {
            countryCodePrimaryPersonMobileTextField.text = "+1"
            countryCodePrimaryPersonTextField.text = "+1"
            countryCodeCompanyFaxTextField.text = "+1"
        }
        removeTransparentView()
    }
    
    func submitInitialRegistrationDetails (details : initialRegistrationDetails) {
        let url = URL(string: "http://sLogisticglobalapiuat.surteltechnologies.com/api/registrationapi/SubmitCarrierInitialRegistration" )!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
            let requestBody = try? JSONEncoder().encode(details)
            
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let session = URLSession.shared
        session.uploadTask(with: request, from: requestBody) { data, response, Error in
            do {
                guard let data = data else { return }
                let dataStruct = try
                    JSONDecoder().decode(initialRegistrationResponse.self, from: data)
                DispatchQueue.main.async {
                    if dataStruct.Status == true {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ShamitMain", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
                        self.present(nextViewController, animated:true, completion:nil)
                        self.alert(title: "Message", message: dataStruct.Message)
                    } else {
                        self.alert(title: "Invalid Data", message: dataStruct.Message)
                    }
                }
            } catch {
                error
            }
        }.resume()
    }
    var validateFields = Bool()
    func validatingFields (textfield: UITextField, name: String) {
        if (textfield.text?.isEmpty == true) {
            let title = name + " text field is empty"
            let message = name + " text field cannot be empty"
            self.alert(title: title, message: message)
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
//        validatingFields(textfield: countryTextField, name: "Country")
//        validatingFields(textfield: zipCodeTextField, name: "Zip Code")
//        validatingFields(textfield: shipperIDTextField, name: "Shipper ID")
//        validatingFields(textfield: carrierCompanyNameTextField, name: "Carrier Company Name")
//        validatingFields(textfield: primaryContactPersonNameTextField, name: "Primary Contact Person Name")
//        validatingFields(textfield: companyFaxNumberTextField, name: "Company Fax Number")
//        validatingFields(textfield: primaryContactPersonPhoneNumberTextField, name: "Primary Contact Person Phone Number")
//        validatingFields(textfield: primaryContactPersonMobileNumberTextField, name: "Primary Contact Person Mobile Number")
//        validatingFields(textfield: primaryContactEmailTextField, name: "Primary Contact Email")
//        validatingFields(textfield: addressTextField, name: "Address line 1")
        //        let details = initialRegistrationDetails.init(CarrierCompanyName: carrierCompanyNameTextField.text!, CarrierCompanyPhoneNumber: companyFaxNumberTextField.text!, PrimaryContactPersonName: primaryContactPersonNameTextField.text!, PrimaryContactPersonPhoneNumber: primaryContactPersonPhoneNumberTextField.text!, PrimaryContactPersonMobileNumber: primaryContactPersonMobileNumberTextField.text!, PrimaryContactEmail: primaryContactEmailTextField.text!, AddressLine1: addressTextField.text!, AdressLine2: addressLine2TextField.text!, CountryId: countryId, StateName: stateTextField.text!, CityName: cityTextField.text!, ZipCode: zipCodeTextField.text!, ShipperCode: shipperIDTextField.text!)
//        submitInitialRegistrationDetails ( details: details)
                
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = Int()
        if textField == self.shipperIDTextField {
            maxLength = 10
        } else if textField == self.carrierCompanyNameTextField || textField == self.primaryContactPersonNameTextField{
            maxLength = 20
        } else if textField == self.companyFaxNumberTextField || textField == self.primaryContactPersonMobileNumberTextField {
            maxLength = 14
        } else if textField == self.primaryContactPersonPhoneNumberTextField {
            maxLength = 12
        } else if textField == self.addressTextField || textField == self.addressLine2TextField {
            maxLength = 200
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func setUpElements () {
        Utilities.standardTextField(textfield: countryTextField)
        Utilities.standardTextField(textfield: zipCodeTextField)
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
        Utilities.standardTextField(textfield: addressLine2TextField)
    }
}
