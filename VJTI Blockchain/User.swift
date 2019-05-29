//
//  User.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 26/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation

class User {
    
    var name : String
    var email: String
    var pubKey: ECPublicKey
    var pvtKey: ECPrivateKey
    
    var pubKeyStr: String {
        return pubKey.pemString
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----\n", with: "")
            .replacingOccurrences(of: "\n-----END PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
    
    var pvtKeyStr: String {
        return pvtKey.pemString
            .replacingOccurrences(of: "-----BEGIN PRIVATE KEY-----\n", with: "")
            .replacingOccurrences(of: "\n-----END PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
    
    // userPin is made to be retrieved from keychain every time it's requested
    var userPin: String {
        return AppDelegate.keychain!["userPin"]!
    }
    
    init () throws {
        name   = AppDelegate.keychain!["name"]!
        email  = AppDelegate.keychain!["email"]!
        pubKey = try ECPublicKey(key: AppDelegate.keychain!["pub"]!)
        pvtKey = try ECPrivateKey(key: AppDelegate.keychain!["pvt"]!)
        
    }
    
    public static func setUserDetails(name: String, email: String) throws {
        try AppDelegate.keychain?.set(name , key: "name")
        try AppDelegate.keychain?.set(email, key: "email")
    }
    
    public static func setCredentials(pin: String) throws {
        
        let p256PrivateKey = try ECPrivateKey.make(for: .prime256v1)
        
        
        let eccPublicKey = try p256PrivateKey.extractPublicKey()
        
        try AppDelegate.keychain?.set(p256PrivateKey.pemString , key: "pvt")
        try AppDelegate.keychain?.set(eccPublicKey.pemString, key: "pub")

        
        try AppDelegate.keychain?.set(pin , key: "userPin")

    }
    
    public static func getPin() -> String? {
        return AppDelegate.keychain!["userPin"]
        
    }

}
