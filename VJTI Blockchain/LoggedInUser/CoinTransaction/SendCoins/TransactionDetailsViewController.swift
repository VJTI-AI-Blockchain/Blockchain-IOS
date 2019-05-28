//
//  TransactionDetailsViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit

class TransactionDetailsViewController:UIViewController {
    
    @IBOutlet weak var userPubKeyInp: UITextField!
    @IBOutlet weak var coinInp: UITextField!
    @IBOutlet weak var messageInp: UITextField!
    
    var receiverPubKey : String {
        return userPubKeyInp.text ?? ""
    }
    
    var totalCoins: Int {
        return Int(coinInp.text ?? "") ?? -1
    }
    
    var messageStr : String {
        return messageInp.text ?? ""
    }

    @IBAction func onSubmit(_ sender: Any) {
        if receiverPubKey.count <= 0 {
            return
        }
        if totalCoins <= 0 {
            return
        }
        if messageStr.count <= 0 {
            return
        }
        
        performSegue(withIdentifier: "verifyTransactionSeguey", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "verifyTransactionSeguey":
            let receiverVC = segue.destination as! VerifyPinViewController
            
            receiverVC.receiverPubKey = receiverPubKey
            receiverVC.totalCoins = totalCoins
            receiverVC.transactionMessage = messageStr
            break
        case .none  : break
            //TODO
        case .some(_): break
            //TODO
        }
    }
}
