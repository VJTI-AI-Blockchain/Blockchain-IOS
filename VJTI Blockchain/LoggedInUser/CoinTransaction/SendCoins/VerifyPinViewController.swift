//
//  VerifyPinViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import SmileLock
import Alamofire
import CryptoSwift
import Security
import BigInt


class VerifyPinViewController: UIViewController {
    
    var transactionObj: TransactionDetails?
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    var passwordContainerView: PasswordContainerView!
    
    let kPasswordDigits = 4
    fileprivate static var tries = 0
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigits)
        passwordContainerView.delegate = self;
        
        passwordContainerView.deleteButton.setImage(UIImage(imageLiteralResourceName: "delete-icon"), for: UIControl.State.normal);
        
        passwordContainerView.deleteButton.setTitle("", for: UIControl.State.normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        VerifyPinViewController.tries = 0
    }
    
    
}

extension VerifyPinViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}


private extension VerifyPinViewController {
    func validation(_ input: String) -> Bool {
        VerifyPinViewController.tries += 1
        return VerifyPinViewController.tries <= 3 && input == User.getPin()
    }
    
    func validationSuccess() {
        
        print("*️⃣ successful 1st pin entry")
        instructionLabel.text = "Pin Verified!"

        //passwordContainerView.clearInput()
        
        //TODO complete transaction
        makeTransaction()
    
        
    }
    
    func validationFail() {
        if VerifyPinViewController.tries < 3 {
            print("*️⃣ failure!")
            instructionLabel.text = "Invalid Pin. (Tries left: \(3 - VerifyPinViewController.tries))"
            passwordContainerView.wrongPassword()
        }
        else {
            print("*️⃣ utter failure!")
            instructionLabel.text = "You are out of tries"
            passwordContainerView.wrongPassword()

        }
    }
    
    func makeTransaction() {
        Alamofire.request(
            NetworkUtilities.MAKE_TRANSACTION_URL,
            method: .post,
            parameters: self.transactionObj?.getJSONObj(),
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"]
            ).responseJSON{
               (response) in
                
                guard response.result.isSuccess,
                let receivedJSON = response.result.value as? [String: Any]
                    else {
                        let data = response.data;
                        let utf8Text = (data != nil) ? (String(data: data!, encoding: .utf8)) : "No response";
                        
                        print("Error in transaction \(response.result), \(String(describing: response.response))")
                        uiUtils.showAlertBox(title: "Transaction Failed", message: utf8Text ?? "", sender: self)
                    return
                }
                
                //print("ONE\n\n",receivedJSON["send_this"], "PUNCH!!!!!!!!",receivedJSON["sign_this"])
                
                self.sendTransaction(
                    send_this: receivedJSON["send_this"] as! String,
                    sign_this: receivedJSON["sign_this"] as! String
                )
        }
        
        
    }
    
    func sendTransaction(send_this sendThis: String, sign_this signThis: String) {
        //print("user,", try! User().pvtKey)
        let a = try! "VJTI".sign(with: User().pvtKey)
        
        print(String(BigUInt(a.r)),String(BigUInt(a.s)))

        let signed = try! signThis.sign(with: User().pvtKey)
        
        print([String(BigUInt(signed.r)), String(BigUInt(signed.s))])


        Alamofire.request(
            NetworkUtilities.SEND_TRANSACTION_URL,
            method: .post,
            parameters: [
                "transaction": sendThis,
                "signature": "[\(String(BigUInt(signed.r))), \(String(BigUInt(signed.s)))]"
            ],
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"]
            ).responseString {
                (response) in
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                    print(utf8Text)
                    //print(response.response)
                    uiUtils.showAlertBox(
                        title: (response.response?.statusCode ?? 400) == 200 ? "Transaction Succeeded" : "Transaction Failed",
                        message: utf8Text,
                        sender: self
                    )
                    return
                }
                
                uiUtils.showAlertBox(
                    title: "Transaction Failed",
                    message: "Invalid Response from the server",
                    sender: self
                )

        }
    }
}
