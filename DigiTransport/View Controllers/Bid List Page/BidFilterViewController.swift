//
//  BidFilterViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 7/22/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class BidFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var MainView: UIView!
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedTextField = UITextField()
    var dataSource = [String]()
    @IBOutlet weak var stackView: UIStackView!
    var p = CGPoint()
    @IBOutlet weak var locationFromTextfield: UITextField!
    @IBOutlet weak var locationToTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var shipperNameTextField: UITextField!
    @IBOutlet weak var bidStatusTextField: UITextField!
    
    @IBOutlet weak var shipToTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
     super.viewDidLoad()
     self.hideKeyboardWhenTappedAround()
     // Do any additional setup after loading the view.
     setUpElements()
     tableView.delegate = self
     tableView.dataSource = self
     tableView.register(dropdownCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc func removeTransparentView() {
        let frames = selectedTextField.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: frames.origin.y, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    @IBAction func onClickBidStatus(_ sender: Any) {
        dataSource = [ "Australia", "India", "United States", "Australia", "India", "United States", "Australia", "India", "United States"]
        var height: CGFloat
        if dataSource.count < 4 { height = CGFloat(dataSource.count * 50) } else { height = 200}
        selectedTextField = bidStatusTextField
        self.p = self.stackView.convert(self.bidStatusTextField.frame.origin, to: self.view.inputView)
        self.p.y += 45
        Utilities.addTransparentView( textField: selectedTextField, tableView: tableView, transparentView: transparentView, view: MainView, point: p, height: height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        selectedTextField.isUserInteractionEnabled = true
    }
    func setUpElements() {
        Utilities.standardTextField(textfield: locationFromTextfield)
        Utilities.standardTextField(textfield: locationToTextfield)
        Utilities.standardTextField(textfield: weightTextfield)
        Utilities.standardTextField(textfield: shipperNameTextField)
        Utilities.standardTextField(textfield: bidStatusTextField)
        Utilities.standardTextField(textfield: shipToTextField)
        Utilities.standardButton(submitButton)
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
        removeTransparentView()
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
