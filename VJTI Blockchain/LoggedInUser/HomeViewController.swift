//
//  FirstViewController.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 22/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var coinCountLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCoinBalance()
        
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(loadCoinBalance), for: .valueChanged)
        
    }

    @objc func loadCoinBalance() {
        let reqJSON : [String: Any] = ["public_key": try! User().pubKeyStr]
        
        
        Alamofire.request(
            NetworkUtilities.CHECK_BALANCE_URL,
            method: .post,
            parameters: reqJSON,
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"]
        )
            .responseString { response in
                switch response.result {
                    case .success(_):
                        if let count = response.result.value{
                            self.coinCountLabel.text = "\(count)"
                    }
                case .failure(_):
                        self.coinCountLabel.text = "Unable to retrieve balance"
            

            }
            self.scrollView.refreshControl?.endRefreshing()

        }
    }
}

