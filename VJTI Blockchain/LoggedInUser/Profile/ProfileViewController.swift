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
    
    
    @IBAction func copyButtonClick(_ sender: UIButton) {
        UIPasteboard.general.string = user.pubKeyStr
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
