//
//  TransactionCell.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 23/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import IGIdenticon

class TransactionCell : UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var transactionAmtLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var senderIdenticon: UIImageView!
    
    func setRow(message: String, amount: Int, timestamp: Int, sender: String) {
        messageLabel?.text = ProfanityFilter.cleanUp(message)
        
        
        transactionAmtLabel?.text = "\(amount) Coins"
        
        if amount < 0 {
            transactionAmtLabel.textColor = #colorLiteral(red: 0.5664872085, green: 0.1796465516, blue: 0.03361117564, alpha: 1)
        }
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        timestampLabel?.text = "\(date.description(with: Locale.current))";
        
        
//        senderIdenticon?.image = GitHubIdenticon().icon(
//            from: sender,
//            size: CGSize(width: 100, height: 100)
//        )
        
        senderIdenticon.image = AndroidIdenticon().getImage(
            from: sender,
            size: CGSize(width: 100, height: 100)
        )
        
        
    }
}
