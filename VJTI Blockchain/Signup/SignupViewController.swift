//
//  SignupViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 24/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController : UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var userName : String {
        return nameTextField.text ?? ""
    }
    
    var userEmail : String {
        return emailTextField.text ?? ""
    }
    
    let emailCheckRegex = try! NSRegularExpression(pattern:
        "^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]{1}|[\\w-]{2,}))@"
        + "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
        + "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
        + "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
        + "[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
            + "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})$");
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    @IBAction func onSubmitDetails(_ sender: Any) {
        print("Submitted")
        
        if userName == "" {
            let invalidUserAlert = UIAlertController(title: "Invalid User Name", message: "Please enter a valid name", preferredStyle: .alert)
            invalidUserAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Invalid name input")
            }));

            self.present(invalidUserAlert, animated: true, completion: nil)

            return;
        }

        if !isValidEmail() {
            let invalidEmailAlert = UIAlertController(title: "Invalid Email", message: "Please enter a valid email ID", preferredStyle: .alert)
            invalidEmailAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Invalid email input")
            }));
            
            self.present(invalidEmailAlert, animated: true, completion: nil)
            
            return;
        }
        
        
        let (publicKey, privateKey) = getKeyPair();
        
        do {
            try AppDelegate.keychain?.set(publicKey , key: "public")
            try AppDelegate.keychain?.set(privateKey, key: "private")
            
            performSegue(withIdentifier: "setPinSeguey", sender: sender);
            
        } catch  {
            print("Error in saving in keychain");
        }

        
    }
    
    private func isValidEmail() -> Bool {
        let range = NSRange(location: 0, length: userEmail.utf16.count)
        
        return emailCheckRegex.firstMatch(in: userEmail, options: [], range: range) != nil
    }
    
    private func getKeyPair() -> (String, String) {
        // TODO secp256r1 curve ECDA with SHA1PRNG random seed
        return ("Public", "Private");
    }
}
