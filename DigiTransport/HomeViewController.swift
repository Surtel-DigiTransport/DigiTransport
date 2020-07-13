//
//  HomeViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 6/20/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import Foundation
import UIKit
class HomeViewController: UIViewController {

    @IBAction func signUpButton(_ sender: Any) {
    }
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var logIn: UIButton!
    @IBAction func logInButton(_ sender: Any) {
    }
    
    @IBOutlet weak var textFieldOne: UITextField!
    
    @IBOutlet weak var textFieldTwo: UITextField!
    
    @IBOutlet weak var textFieldThree: UITextField!
    
    @IBOutlet weak var textFieldFour: UITextField!
    
    @IBOutlet weak var textFieldFive: UITextField!
    
    @IBOutlet weak var textFieldSix: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var poweredBy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor.init(red: 255/255, green: 152/255, blue: 0/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 255/255, green: 152/255, blue: 0/255, alpha: 1)
        signUp.backgroundColor = UIColor.init(red: 255/255, green: 152/255, blue: 0/255, alpha: 1)
        signUp.layer.cornerRadius = 15.0
        signUp.tintColor = UIColor.white
        
        logIn.backgroundColor = UIColor.init(red: 255/255, green: 152/255, blue: 0/255, alpha: 1)
        logIn.layer.cornerRadius = 15.0
        logIn.tintColor = UIColor.white
        
        let checkImage = UIImage(named: "icon1")
        addImage(txtField: textFieldOne, andImage: checkImage!)
        addImage(txtField: textFieldTwo, andImage: checkImage!)
        addImage(txtField: textFieldThree, andImage: checkImage!)
        addImage(txtField: textFieldFour, andImage: checkImage!)
        addImage(txtField: textFieldFive, andImage: checkImage!)
        addImage(txtField: textFieldSix, andImage: checkImage!)
        // Do any additional setup after loading the view.
    }
    func addImage( txtField: UITextField, andImage img: UIImage){
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        imageView.image = img
        txtField.leftView = imageView
        txtField.leftViewMode = .always
        
    }

}
