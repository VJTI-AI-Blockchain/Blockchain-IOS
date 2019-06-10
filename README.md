# Blockchain-iOS

The official iOS port for the [VJTI Blockchain Wallet APP](https://github.com/VJTI-AI-Blockchain/VJTI-Blockchain-Wallet).

## Development Software:
- XCode : >=10 (my version: 10.2.1)
- iOS   : >=12
- Current Supported Device (tested on emulator): all iPhone devices supporting iOS 12 


## Progress
- [x] Create Profile credentials
- [x] View Profile Details
- [x] Receving coins via QR Code
- [x] Create Backup Profile encrypted file (iOS backup can be retrieved on Android app and visa versa)
- [x] Send Coins using public key string
- [ ] Scan QR Code (awaiting testing)
- [ ] Retrieve backup (awaiting testing)
- [X] Cross Device View Support
- [X] Identicons Match Android Identicons
- [ ] Public Beta Testing

### Installation Instructions
1. Open the 'VJTI Blockchain.xcworkspace' to work on the project
2. All dependencies installed via Cocoapods can be found in the Pods/ Directory
3. Some dependencies are edited to suit the project
4. To install a new dependency using Cocoapod, 
   a. Add the dependency name and version in the Podfile 
   b. Type the following command in your terminal
   ```
   pod install
   ```
5. To uninstall a dependency using Cocoapod, 
   
      a. Remove the dependency name and version in the Podfile 
      b. Type the following command in your terminal
   
   ```
   pod install
   ```

#### NOTE: The Pods/ directory is already provided in the repository so you need not follow instructions 4 & 5 unless you want to add/remove dependencies.

### Dependencies

#### BlueECC https://github.com/IBM-Swift/BlueECC
A cross platform Swift implementation of Elliptic Curve Digital Signature Algorithm (ECDSA) and Elliptic Curve Integrated Encryption Scheme (ECIES). This allows you to sign, verify, encrypt and decrypt using elliptic curve keys.


#### SmileLock https://github.com/recruit-lifestyle/Smile-Lock/
A customizable password/pin ViewController used for user pin inputs

#### KeychainAccess https://cocoapods.org/pods/KeychainAccess
A simple Swift wrapper for Keychain that works on iOS and OS X. Makes using Keychain APIs extremely easy and much more palatable to use in Swift. Used to storing user keys and meta data on the device securely.

#### MarqueeLabel https://github.com/cbpowell/MarqueeLabel
A custom UILabel with auto-scrolling animation to display long text. Used in Profile View to show user's public key

#### QRCode https://cocoapods.org/pods/QRCode
A QRCode image generator used to generate a QRCode for the user's public key

#### IGIdenticon https://cocoapods.org/pods/IGIdenticon
An unique identicon generator library. Note: this library was replaced by a custom made Identicon library based on [delight-im's Android Identicons](https://github.com/delight-im/Android-Identicons)

#### Alamofire https://cocoapods.org/pods/Alamofire
Alamofire is an HTTP networking library written in Swift. All networking has been handled by the Alamofire library.

#### CryptoSwift https://github.com/krzyzanowskim/CryptoSwift
Crypto related functions and helpers for Swift implemented in Swift. Message Signing, key hashing and other cryptographic functionalities were implemented partially using this library.

#### SwiftyJSON https://github.com/SwiftyJSON/SwiftyJSON
JSON handler to send/receive JSON data in HTTP requests.

#### QRCode Reader https://github.com/yannickl/QRCodeReader.swift/
A QR Code reader ViewController for scanning receiver's public key.

#### BigInt https://github.com/attaswift/BigInt
Used in formatting bytes to base10 formatted data to be sent to the server for transaction verifications

---

### Additional Notes
1. You cannot test the QRCode Scanner and Backup Account Retrieval Feature without an Apple Developer Account
2. You have to use either an Emulator/ your personal device to test the app. If you want to test-deploy it on someone else's device, you would need the Apple Developer Account.

#### Developer
> Ameya Daddikar: ameyadaddikar@gmail.com
