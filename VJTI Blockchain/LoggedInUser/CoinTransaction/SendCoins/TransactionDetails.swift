//
//  TransactionDetails.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 28/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation

class TransactionDetails {
    var bounty : Int
    var receiverKey: String
    var senderKey: String
    var message: String
    
    init(coins bounty: Int, receiver receiverKey: String, message: String) {
        self.bounty = bounty
        self.receiverKey = receiverKey
        self.message = message
        
        self.senderKey = try! User().pubKeyStr
    }
    func getJSONObj() -> [String: Any] {
        return [
            "bounty": bounty,
            "receiver_public_key": receiverKey,
            "sender_public_key": senderKey,
            "message": message
        ]
    }
}
