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
    
    @IBOutlet private weak var passwordStackView: UIStackView!
    
    private var passwordContainerView: PasswordContainerView!
    
    private let kPasswordDigits = 4
    fileprivate static var tries = 0
    
    @IBOutlet private weak var instructionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigits)
        //passwordContainerView.delegate = self;
        
        passwordContainerView.deleteButton.setImage(UIImage(imageLiteralResourceName: "delete-icon"), for: UIControl.State.normal);
        
        passwordContainerView.deleteButton.setTitle("", for: UIControl.State.normal)
    }
    
    
}

private extension SecretPinSetupViewController {
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
            pinInstructionLabel.text = "Invalid Pin"
            passwordContainerView.wrongPassword()
        }
        else {
            print("*️⃣ utter failure!")
            pinInstructionLabel.text = "You are out of tries"
            passwordContainerView.wrongPassword()

        }
    }
}
