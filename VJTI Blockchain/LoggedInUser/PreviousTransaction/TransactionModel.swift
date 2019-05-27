//
//  TransactionModel.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 23/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation

class TransactionModel {
    var message   : String;
    var amount    : Int;
    var timestamp : Int;
    var sender    : String;
    
    init(message: String, amount: Int, timestamp: Int, sender: String) {
        self.message = message;
        self.amount  = amount;
        self.timestamp = timestamp;
        self.sender  = sender;
    }
    
}
