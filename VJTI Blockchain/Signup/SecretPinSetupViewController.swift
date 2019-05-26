//
//  SecretPinSetupViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 24/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import SmileLock

class SecretPinSetupViewController : UIViewController {
    
    
    
    @IBOutlet weak var passwordStackView: UIStackView!
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigits = 4
    
    @IBOutlet weak var pinInstructionLabel: UILabel!
    
    var pinString : String?
    var firstPinInp = true {
        didSet {
            if firstPinInp {
                pinInstructionLabel.text = "Try Again! Setup your transaction PIN (4 digits)";
            }
            else {
                pinInstructionLabel.text = "Confirm your pin";
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigits)
        passwordContainerView.delegate = self;
        
    passwordContainerView.deleteButton.setImage(UIImage(imageLiteralResourceName: "delete-icon"), for: UIControl.State.normal);
        
        passwordContainerView.deleteButton.setTitle("", for: UIControl.State.normal)
    }
    
}

extension SecretPinSetupViewController: PasswordInputCompleteProtocol {
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

private extension SecretPinSetupViewController {
    func validation(_ input: String) -> Bool {
        
        if firstPinInp {
            pinString = input
            return true
        }
        else {
            return pinString == input
        }
    }
    
    func validationSuccess() {
        
        if firstPinInp {
            print("*️⃣ successful 1st pin entry")
            passwordContainerView.clearInput()
            firstPinInp = false
        }
        else {
            do {
                try User.setCredentials(pin: pinString!)

                performSegue(withIdentifier: "successfuluserRegisterSeguey", sender: nil);

            } catch  {
                print("Error in saving in keychain");
                passwordContainerView.wrongPassword();
            }
        }
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        firstPinInp = true
        passwordContainerView.wrongPassword()
    }
}
