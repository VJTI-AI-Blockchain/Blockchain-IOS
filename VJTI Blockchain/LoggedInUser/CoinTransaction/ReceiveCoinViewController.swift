//
//  ReceiveCoinViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import QRCode

class ReceiveCoinViewController: UIViewController {
    
    @IBOutlet weak var publicKeyQRImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = try! User()
        
        userNameLabel.text = user?.name
        
        var qrCode   = QRCode((user?.pubKeyStr)!)
        qrCode?.size = CGSize(width: 200, height: 200)
            
        publicKeyQRImage.image = qrCode?.image
        
    }
}
