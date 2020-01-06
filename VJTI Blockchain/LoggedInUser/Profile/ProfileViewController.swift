//
//  ProfileViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import MarqueeLabel
import IGIdenticon

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    var user : User!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var publicKeyLabel: MarqueeLabel!
    @IBOutlet weak var profileImageIdenticonView: UIImageView!
    
    @IBOutlet weak var backupPasswordTextView: UITextField!
    
    @IBAction func copyButtonClick(_ sender: UIButton) {
        UIPasteboard.general.string = user.pubKeyStr
    }
    
    @IBAction func backupProfileAction(_ sender: Any) {
        let backupPwd = backupPasswordTextView.text ?? ""
        
        if backupPwd.count < 12 {
            showMessage(title: "Password is too short", message: "Please choose a password that is at least 12 characters long")
            return
        }
        
        do {
            try BackupUtils.createBackup(withPassword: backupPwd)
            
            showMessage(title: "Backup Successful", message: "You can find the backup in the Documents directory")
        } catch {
            showMessage(title: "Backup Failed", message: "An unexpected error occured while backing up your credentials.")
        }
        
    }
    
    private func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert::\(title)")
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
//  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//   super.touchesBegan(touches, with: event)
//       view.endEditing(true)
//      print("touching--------------------------")
//
//  self.backupPasswordTextView.resignFirstResponder()
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textShouldReturn")
        backupPasswordTextView.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backupPasswordTextView.delegate = self
        
        user = try! User()

        userNameLabel.text  = ProfanityFilter.cleanUp(user.name)
        emailLabel.text     = ProfanityFilter.cleanUp(user.email)
        publicKeyLabel.text = user.pubKeyStr
        
    
        //profileImageIdenticonView.image = GitHubIdenticon().icon(from: user.pubKeyStr, size: CGSize(width: 100, height: 100))
        
//        profileImageIdenticonView.image =
//        AndroidIdenticon().getImage(
//            from: "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAECfeFz2xjqy/PPmlVgnKiIETxhy45uVcvTFu9he54ANDk1QvIHXfNU5n9C3Sezc2NyX++TJQqouDQOjZcsObRjg==",
//            size: CGSize(width: 100, height: 100)
//        )

        profileImageIdenticonView.image =
            AndroidIdenticon().getImage(
                from: user.pubKeyStr,
                size: CGSize(width: 200, height: 200)
        )

    }
}
