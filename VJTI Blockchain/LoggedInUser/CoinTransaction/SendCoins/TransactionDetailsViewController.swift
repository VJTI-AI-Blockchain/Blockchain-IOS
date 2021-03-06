//
//  TransactionDetailsViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit

class TransactionDetailsViewController:UIViewController, UITextFieldDelegate {
    
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
    
    var scannedPubKey : String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if scannedPubKey != nil {
            userPubKeyInp.text = scannedPubKey
            scannedPubKey = nil
        }
        
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
                message: "Please use a positive integer of coins for the transaction",
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
        
        if !ProfanityFilter.isCleanWord(messageStr) {
            uiUtils.showAlertBox(
                title: "Abusive Content Detected",
                message: "Please refrain from using offensive words in your message.",
                sender: self
            )
        }
        
        performSegue(withIdentifier: "verifyTransactionSeguey", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "verifyTransactionSeguey":
            let receiverVC = segue.destination as! VerifyPinViewController
            receiverVC.transactionObj = TransactionDetails(
                                            coins    : totalCoins,
                                            receiver : receiverPubKey,
                                            message  : messageStr
                                        )
            
            break
        case .none  : break
            //TODO
        case .some(_): break
            //TODO
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
       
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userPubKeyInp.returnKeyType=UIReturnKeyType.done
        messageInp.returnKeyType=UIReturnKeyType.done
        coinInp.returnKeyType=UIReturnKeyType.done
    }
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           print("textShouldReturn")
           userPubKeyInp.resignFirstResponder()
        coinInp.resignFirstResponder()
        messageInp.resignFirstResponder()
           return true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coinInp.delegate=self
        self.messageInp.delegate=self
        self.userPubKeyInp.delegate=self
    }
}
