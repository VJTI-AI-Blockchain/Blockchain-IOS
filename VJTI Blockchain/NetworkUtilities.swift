
//
//  NetworkUtilities.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation

class NetworkUtilities {
    
    private static let api_rotocol  = "http://"
    private static let host_addr    = "chain.lbsnaa.in"
    
    static let port_num     = "9000"
    
    static var API_ROOT : String {
        return "\(NetworkUtilities.api_rotocol)\(NetworkUtilities.host_addr):\(NetworkUtilities.port_num)"
    }
    
    static var CHECK_BALANCE_URL : String {
        return NetworkUtilities.API_ROOT + "/checkBalance"
    }
    
    static var MAKE_TRANSACTION_URL : String {
        return NetworkUtilities.API_ROOT + "/makeTransaction"
    }

    static var SEND_TRANSACTION_URL : String {
        return NetworkUtilities.API_ROOT + "/sendTransaction"
    }

    static var TRANSACTION_HISTORY : String {
        return NetworkUtilities.API_ROOT + "/transactionHistory"
    }

}
