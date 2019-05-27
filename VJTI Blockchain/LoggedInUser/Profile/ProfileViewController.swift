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

class ProfileViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = try! User()

        userNameLabel.text  = user.name
        emailLabel.text     = user.email
        publicKeyLabel.text = user.pubKeyStr

        profileImageIdenticonView.image = GitHubIdenticon().icon(from: user.pubKeyStr, size: CGSize(width: 100, height: 100))
        
    }
}
