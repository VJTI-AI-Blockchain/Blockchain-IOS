//
//  PreviousTransactionsTableViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 23/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit

class PreviousTransactionsTableViewController : UITableViewController {
    
    private var dummyData = [
        TransactionModel(message: "This is message 1", amount: 300, timestamp: "05-03-2019 14:15:46"),
        TransactionModel(message: "This is a comparatively long message that may take two lines", amount: 75, timestamp: "06-03-2019 22:45:30"),
        TransactionModel(message: "This is another message", amount: 56, timestamp: "07-03-2019 11:15:46"),
        TransactionModel(message: "This is a sample message", amount: 40, timestamp: "07-03-2019 04:18:07"),
        TransactionModel(message: "This is a sample message", amount: 20, timestamp: "09-03-2019 12:05:16"),
        TransactionModel(message: "This is a sample message", amount: 20, timestamp: "09-03-2019 12:05:16"),
        TransactionModel(message: "This is a sample message", amount: 20, timestamp: "09-03-2019 12:05:16"),

        ];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let transactionCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TransactionCell;
        
        transactionCell.messageLabel.text = dummyData[indexPath.row].message;
        
        transactionCell.transactionAmtLabel.text = "\(dummyData[indexPath.row].amount)";
        
        transactionCell.timestampLabel.text = dummyData[indexPath.row].timestamp;
        
        return transactionCell;
    }
}
