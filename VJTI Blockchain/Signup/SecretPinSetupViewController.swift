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
        return input == "1234"
    }
    
    func validationSuccess() {
        print("*️⃣ success!")
        dismiss(animated: true, completion: nil)
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        passwordContainerView.wrongPassword()
    }
}
