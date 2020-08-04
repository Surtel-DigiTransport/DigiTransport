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
    var countryDetails = [countryStruct]()
    var countryId = Int()
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedTextField = UITextField()
    var dataSource = [String]()
    var p = CGPoint()
    @IBOutlet var MainView: UIView!
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
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        setUpElements()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(dropdownCell.self, forCellReuseIdentifier: "Cell")
        getCountries()
        stateTextField.isUserInteractionEnabled = false
        cityTextField.isUserInteractionEnabled = false
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
            self.tableView.frame = CGRect(x: 0, y: frames.origin.y, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    @IBAction func onClickSelectCountry(_ sender: Any) {
        
       
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = countryTextField
        self.p = self.countryTextField.convert(self.countryTextField.frame.origin, to: self.view)
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        selectedTextField.isUserInteractionEnabled = true
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
                            let alert = UIAlertController(title: "Invalid Zip Code", message: dataStruct.Message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true)
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
        removeTransparentView()
    }
    
    func submitInitialRegistrationDetails (details : initialRegistrationDetails) {
        let url = URL(string: "http://sLogisticglobalapiuat.surteltechnologies.com/api/registrationapi/SubmitCarrierInitialRegistration" )!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: details, options: []) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            guard let data = data else { return }
            do {
                let dataStruct = try
                JSONDecoder().decode(stateAndCityStruct.self, from: data)
                DispatchQueue.main.async {
                    if dataStruct.Status == true {
                        self.stateTextField.text = dataStruct.StateName
                        self.cityTextField.text = dataStruct.CityName
                    } else {
                        let alert = UIAlertController(title: "Invalid Zip Code", message: dataStruct.Message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            } catch {
                print(err)
            }
            

        }.resume()
        
        
    }
    
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let details = initialRegistrationDetails.init(CarrierCompanyName: carrierCompanyNameTextField.text!, CarrierCompanyPhoneNumber: companyFaxNumberTextField.text!, PrimaryContactPersonName: primaryContactPersonNameTextField.text!, PrimaryContactPersonPhoneNumber: primaryContactPersonPhoneNumberTextField.text!, PrimaryContactPersonMobileNumber: primaryContactPersonMobileNumberTextField.text!, PrimaryContactEmail: primaryContactEmailTextField.text!, AddressLine1: addressTextField.text!, AdressLine2: addressLine2TextField.text!, CountryId: countryId, StateName: stateTextField.text!, CityName: cityTextField.text!, ZipCode: zipCodeTextField.text!, ShipperCode: shipperIDTextField.text!)
        submitInitialRegistrationDetails ( details: details)
        
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
    }

}



