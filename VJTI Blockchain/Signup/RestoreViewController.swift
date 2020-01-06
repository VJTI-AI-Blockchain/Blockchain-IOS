//
//  RestoreViewController.swift
//  VJTI Blockchain
//
//  Created by VJTI BLOCKCHAIN on 06/01/20.
//  Copyright © 2020 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import UIKit
import FileBrowser

class RestoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileBrowser = FileBrowser()
        present(fileBrowser, animated: true, completion: nil)
        
        fileBrowser.didSelectFile = { (file: FBFile) -> Void in
            print(file.filePath)
        }
    }
}
