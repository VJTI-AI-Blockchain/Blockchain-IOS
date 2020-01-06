//
//  BackupUtils.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 27/05/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import CryptoSwift

class BackupUtils {
    
    private static func getAESEncryptor(key: String) -> AES {
        
        let pwd_key  = Data(key.bytes).sha1().bytes
        
        let shortPwd = pwd_key.prefix(16)
        let encryptor = try! AES.init(key: Array(shortPwd), blockMode: ECB(), padding: .pkcs5)
        
        return encryptor
    }
    
    static func createBackup(withPassword password: String) throws {
        let userDetails = try User()
        let encryptor   = getAESEncryptor(key: password)
        
        let userJSON : [String: String] = [
            "name" : userDetails.name,
            "email": userDetails.email,
            "publicKey" : userDetails.pubKeyStr,
            "privateKey": userDetails.pvtKeyStr,
            "pin": User.getPin()!
        ]
        
        //let userJSON = "{\"name\":\"\(userDetails.name)\",\"emai l\":\"\(userDetails.email)\",\"publicKey\":\"\(userDetails.pubKeyStr)\",\"privateKey\":\"\(userDetails.pvtKeyStr)\",{\"pin\":\"\(User.getPin() ?? "1234")\"}";
        
        let usrJSONObj = try JSONSerialization.data(withJSONObject: userJSON, options: [])
        let jsonString = String(data: usrJSONObj, encoding: String.Encoding.utf8)
        
        let cypherText = try encryptor.encrypt(Array(jsonString!.utf8)).toBase64()
        print(cypherText ?? "Well Shit");
        try saveToFile(backup: cypherText!)
    }
    
    private static func saveToFile(backup:String) throws {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        
      
        //let fileName          = documentDirectory.appendingPathComponent("credentials\(Date.init().hashValue).txt")
        let fileName          = documentDirectory.appendingPathComponent("credentials.txt")
        
        try backup.write(to: fileName, atomically: true, encoding: String.Encoding.utf8);
        
    }
}
