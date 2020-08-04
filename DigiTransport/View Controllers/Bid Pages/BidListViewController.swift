//
//  BidListViewController.swift
//  DigiTransport
//
//  Created by Tanay Agrawal on 7/9/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//

import UIKit

class BidListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           5
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "bidCell", for: indexPath) as! BidCell
           cell.bidID.text = "BidID"
           cell.bidTItle.text = "Bid Title"
           cell.bidStatus.text = "Status •"
           cell.shipperName.text = "Shipper Name"
           cell.bidStartDate.text = "Bid Start Date"
           cell.bidEndDate.text = "Bid End Date"
           cell.locationFrom.text = "Location From"
           cell.locationThru.text = "Location Thru"
           cell.specialNote.text = "Special Note"
            cell.layer.cornerRadius = 20
           return cell
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
