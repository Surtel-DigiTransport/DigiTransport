//
//  FinalRegistrationPageViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 7/4/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class FinalRegistrationPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedTextField = UITextField()
    var dataSource = [String]()
    var p = CGPoint()
    var countTrailer = 0
    var countServiceArea = 0
    var countState = 0
    var countServiceCategories = 0
    var trailerArray = [String]()
    var serviceAreaArray = [String]()
    var serviceCategoryArray = [String]()
    var stateArray = [String]()
    @IBOutlet var MainView: UIView!
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
        setUpElements()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(dropdownCell.self, forCellReuseIdentifier: "Cell")
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardDidShow(notification:)),
        name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardDidHide(notification:)),
        name: UIResponder.keyboardDidHideNotification, object: nil)
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
    
    @objc func removeTransparentView() {
        let frames = selectedTextField.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: self.p.y, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func OnClickPaymentAccountType(_ sender: Any) {
        dataSource = [ "Australia","India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = paymentAccountTypeTextField
        self.p = self.scrollView.convert(self.paymentAccountTypeTextField.frame.origin, to: self.view.inputView)
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func OnClickTrailerType(_ sender: Any) {
        dataSource = [ "Australia", "India", "United States", "Australia", "India", "United States", "Australia", "India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = trailerTypeTextField
        self.p = self.scrollView.convert(self.trailerTypeTextField.frame.origin, to: self.view.inputView)
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    @IBAction func OnClickServiceCategories(_ sender: Any) {
        dataSource = [ "Australia", "India", "United States", "Australia", "India", "United States", "Australia", "India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = serviceCategoriesTextField
        self.p = self.scrollView.convert(self.serviceCategoriesTextField.frame.origin, to: self.view.inputView)
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    @IBAction func OnClickServiceArea(_ sender: Any) {
        dataSource = [ "Australia", "India", "United States", "Australia", "India", "United States", "Australia", "India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = serviceAreaTextField
        self.p = self.scrollView.convert(self.serviceAreaTextField.frame.origin, to: self.view.inputView)
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    @IBAction func OnClickState(_ sender: Any) {
        dataSource = [ "Australia", "India", "United States", "Australia", "India", "United States", "Australia", "India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = stateTextField
        self.p = self.scrollView.convert(self.stateTextField.frame.origin, to: self.view.inputView)
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    @IBAction func OnClickBusiness(_ sender: Any) {
        dataSource = [ "Australia", "India", "United States", "Australia", "India", "United States", "Australia", "India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = businessTypeTextField
        p = self.scrollView.convert(self.businessTypeTextField.frame.origin, to: self.view.inputView)
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        selectedTextField.isUserInteractionEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        if selectedTextField == trailerTypeTextField || selectedTextField == serviceAreaTextField || selectedTextField == serviceCategoriesTextField || selectedTextField == stateTextField {
            if cell.isSelected == true {
                
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if (selectedTextField == trailerTypeTextField)
        {
            if cell!.isSelected == true {
                countTrailer += 1
                trailerArray.append(dataSource[indexPath.row])
            }
            selectedTextField.text =  " \(countTrailer) items selected"
        } else if (selectedTextField == serviceAreaTextField)
        {
            if cell!.isSelected == true {
                countServiceArea += 1
                serviceAreaArray.append(dataSource[indexPath.row])
            }
            selectedTextField.text =  " \(countServiceArea) items selected"
        } else if (selectedTextField == serviceCategoriesTextField)
        {
            if cell!.isSelected == true {
                countServiceCategories += 1
                serviceCategoryArray.append(dataSource[indexPath.row])
            }
            selectedTextField.text =  " \(countServiceCategories) items selected"
        } else if (selectedTextField == stateTextField)
        {
            if cell!.isSelected == true {
                countState += 1
                stateArray.append(dataSource[indexPath.row])
            }
            selectedTextField.text =  " \(countState) items selected"
        } else {
            selectedTextField.text = dataSource[indexPath.row]
            removeTransparentView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if (selectedTextField == trailerTypeTextField)
        {
            countTrailer -= 1
            selectedTextField.text =  " \(countTrailer) items selected"
            
        } else if (selectedTextField == serviceAreaTextField)
        {
            countServiceArea -= 1
            selectedTextField.text =  " \(countServiceArea) items selected"
            
        } else if (selectedTextField == serviceCategoriesTextField)
        {
                countServiceCategories -= 1
                selectedTextField.text =  " \(countServiceCategories) items selected"
            
        } else if (selectedTextField == stateTextField)
        {
            countState -= 1
            selectedTextField.text =  " \(countState) items selected"
            
        }
        
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
    
}
