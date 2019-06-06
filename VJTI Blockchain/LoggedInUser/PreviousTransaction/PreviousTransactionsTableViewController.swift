//
//  PreviousTransactionsTableViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 23/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import IGIdenticon

class PreviousTransactionsTableViewController : UITableViewController {
    
    
    private var previousTransactions: [TransactionModel] = []
    //let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        refreshControl = UIRefreshControl()
        
        refreshControl?.addTarget(self, action: #selector(loadPreviousTransactions), for: .valueChanged)
        
        self.tableView.addSubview(refreshControl!)
        
        loadPreviousTransactions()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previousTransactions.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let transactionCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionCell;
        
        let transactionDetails = previousTransactions[indexPath.row]
        
        transactionCell.setRow(
            message  : transactionDetails.message,
            amount   : transactionDetails.amount,
            timestamp: transactionDetails.timestamp,
            sender   : transactionDetails.sender
        );
        
        return transactionCell;
    }
    
    @objc func loadPreviousTransactions() {
        print("called loadPreviousTransactions")
        
        previousTransactions.removeAll()
        let reqJSON : [String: Any] = ["public_key": try! User().pubKeyStr]
    
        
        Alamofire.request(
            NetworkUtilities.TRANSACTION_HISTORY,
            method: .post,
            parameters: reqJSON,
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"]
            )
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        
                        if !(200 ..< 300).contains(response.response?.statusCode ?? 404) {
                            uiUtils.showAlertBox(
                                title: "Unable to load Transaction History",
                                message: "Please check your internet connection. Contact us in case the problem still persists.",
                                sender: self)
                        }
                            self.refreshControl?.endRefreshing()
                            self.tableView.reloadData()
                        return
                }

                //TODO cleanup
                let jsonData  = JSON(value).rawString()?.data(using: String.Encoding.utf8)
                var jsonArray = try! JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments) as! [Any
                ]
                
                for i in jsonArray.indices {
                    
                    let x = JSON(jsonArray[i] as! String).rawString()?.data(using: String.Encoding.utf8)
                    let details = try! JSONSerialization.jsonObject(with: x!, options: .allowFragments) as![String: Any]
                    print(details["amount"] as! Int)

                    self.previousTransactions.append(TransactionModel(
                        message: details["message"] as! String,
                        amount: details["amount"] as! Int,
                        timestamp: details["timestamp"] as! Int,
                        sender: details["address"] as! String
                    ))
                }
                
//                for i in 0..<jsonArray.count {
//
//                    let details : NSDictionary = jsonArray[i] as! NSDictionary
//
//                    self.previousTransactions.append(TransactionModel(
//                        message: details["message"] as! String,
//                        amount: details["amount"] as! Int,
//                        timestamp: details["timestamp"] as! String,
//                        sender: details["address"] as! String
//                    ))
//                }

                print("Previous Transactions:",self.previousTransactions.count)

                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
        
        }
    }
}
