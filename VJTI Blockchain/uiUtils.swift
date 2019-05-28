//
//  uiUtils.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 28/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit

class uiUtils {
    static func showAlertBox(title: String, message: String, sender: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert::\(title)")
        }))
        sender.present(alert, animated: true, completion: nil)
    }
}
