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

class VerifyPinViewController: UIViewController {
    
    var receiverPubKey: String?
    var totalCoins : Int?
    var transactionMessage: String?
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    var passwordContainerView: PasswordContainerView!
    
    let kPasswordDigits = 4
    fileprivate static var tries = 0
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print("fuck")
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigits)
        print("you")
        passwordContainerView.delegate = self;
        
        passwordContainerView.deleteButton.setImage(UIImage(imageLiteralResourceName: "delete-icon"), for: UIControl.State.normal);
        
        passwordContainerView.deleteButton.setTitle("", for: UIControl.State.normal)
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
        return input == User.getPin()
    }
    
    func validationSuccess() {
        
        print("*️⃣ successful 1st pin entry")
        passwordContainerView.clearInput()
        
        //TODO complete transaction
    
        
    }
    
    func validationFail() {
        if VerifyPinViewController.tries <= 3 {
            print("*️⃣ failure!")
            instructionLabel.text = "Invalid Pin"
            passwordContainerView.wrongPassword()
        }
        else {
            print("*️⃣ utter failure!")
            instructionLabel.text = "You are out of tries"
            passwordContainerView.wrongPassword()

        }
    }
}
