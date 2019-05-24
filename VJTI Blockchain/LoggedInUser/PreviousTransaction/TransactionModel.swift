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
    var timestamp : String;
    
    init(message: String, amount: Int, timestamp: String) {
        self.message = message;
        self.amount  = amount;
        self.timestamp = timestamp;
    }
}
