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
        if receiverPubKey.count < 90 {
            uiUtils.showAlertBox(
                title: "Invalid Public Key",
                message: "Please provide a proper public key for the sender or use the QR Code",
                sender: self)
            return
        }
        if totalCoins <= 0 {
            uiUtils.showAlertBox(
                title: "Invalid Coin Amount",
                message: "Please use a positive integer of cins for the transaction",
                sender: self)
            return
        }
        if messageStr.count <= 0 {
            uiUtils.showAlertBox(
                title: "Empty Message",
                message: "Please write in a message for the transaction",
                sender: self)
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
