//
//  CommunicationPage.swift
//  DigiTransport
//
//  Created by Shamit Surana on 7/10/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class CommunicationViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var text:String = ""
    
    var communicationcells: [Communication] = []
    
    var communicationType: [String] = ["Cell", "Cell7"]
    var subject: [String] = ["Cell1", "Cell6"]
    var partnerType: [String] = ["Cell2", "Cell5"]
    var partnerID: [String] = ["Cell3", "Cell4"]
    var effectiveFrom: [String] = ["Cell4", "Cell3"]
    var effectiveTo: [String] = ["Cell5", "Cell2"]
    var downtimeFrom: [String] = ["Cell6", "Cell1"]
    var downtimeTo: [String] = ["Cell7", "Cell"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        
        applyTheme()
        communicationcells = createArray()
    }
    
    
    func applyTheme() {
        tableView.backgroundColor = Theme.current.backgroundColor
        backgroundView.backgroundColor = Theme.current.backgroundColor

    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func createArray() -> [Communication] {
        var tempcell: [Communication] = []
    
        for i in  0..<communicationType.count {
            let Cell1 = Communication(
            communicationType: communicationType[i],
            subject: subject[i],
            partnerType: partnerType[i],
            partnerID: partnerID[i],
            effectiveFrom: effectiveFrom[i],
            effectiveTo: effectiveTo[i],
            downtimeFrom: downtimeFrom[i],
            downtimeTo: downtimeTo[i])
            
            tempcell.append(Cell1)
            
            
        }
        return tempcell
    }
    
//    communicationType
//          subject
//          partnerType
//          partnerID
//          effectiveFrom
//          effectiveTo
//          downtimeFrom
//          downtimeTo
}

extension CommunicationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communicationcells.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let communicationCell = communicationcells[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunicationCell") as! CommunicationCell
        
        cell.backgroundColor = Theme.current.backgroundColor

        cell.selectionStyle = .none
        cell.setCommunication(communication: communicationCell)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
        myComputedProperty = indexPath.row
        performSegue(withIdentifier: "CommunicationSegue", sender: self)
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            selectedCell!.backgroundColor = Theme.current.backgroundColor
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = Theme.current.backgroundColor
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("ok1")
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        print("ok2")
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath)
        selectedCell!.backgroundColor = Theme.current.backgroundColor
    }
    
    
    struct Holder {
        static var _myComputedProperty:Int = -1
    }
    var myComputedProperty:Int {
        get {
            return Holder._myComputedProperty
        }
        set(newValue) {
            Holder._myComputedProperty = newValue
        }
    }
    


//    @objc func buttonTapped(_ sender: UIButton) {
//        myComputedProperty = sender.tag
//        performSegue(withIdentifier: "CommunicationSegue", sender: self)
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsController = segue.destination as! CommunicationDetailsViewController
        detailsController.passthroughstring = String(myComputedProperty)
        

    }
    
    
    
}

