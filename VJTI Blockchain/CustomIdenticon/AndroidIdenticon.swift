//
//  AndroidIdenticon.swift
//  VJTI Blockchain
//
//  Created by Ameya Daddikar on 05/06/19.
//  Copyright © 2019 Veermata Jijabai Technological Institute. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import CryptoSwift


class AndroidIdenticon {
    
    let rowCount = 4
    let colCount = 4
    
    var mHash : [UInt8]?
    
    func getImage(from string: String, size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        
        mHash = string.data(using: String.Encoding.utf8)?.sha256().bytes
        
        
        // orientation .right to match rotation of android identicon
        return UIImage(
            cgImage: getIcon(size: size),
            scale: 1.0,
            orientation: .right
        )
    }
    
    
    func getIcon(size: CGSize) -> CGImage {
    
        
        let context = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )!
        context.setShouldAntialias(false)
        
        let color    = getIconColor()
        let cellsize = CGSize(
            width : size.width  / CGFloat(rowCount),
            height: size.height / CGFloat(colCount)
        )
        
        context.setFillColor(color);
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                if (isCellVisible(row: row, col: col)) {
                    
                    let (x, y) = (CGFloat(row) * cellsize.width, CGFloat(col) * cellsize.height);
                    
                    context.fill(CGRect(
                        x: x,
                        y: y,
                        width: cellsize.width,
                        height: cellsize.height
                    ))
                }
            }
        }
        
        let image = context.makeImage()
        
        
        return image!;
    }
    
    func getByte(index : Int) -> UInt8 {
        if mHash == nil {
            return 0
        }
        
        return mHash?[index % (mHash?.count)!] ?? 0
    }
    
    func isCellVisible(row: Int, col: Int) -> Bool {
        if mHash == nil {
            return false
        }
        
        return getByte(index: 3 + row * colCount + col) < 128
        
    }
    
    func getIconColor() -> CGColor {
        
        // returns color as per the Android app specification
        // using byte 0,1,2
        
        return UIColor(
            
            red  : ((CGFloat(getByte(index: 0)) + 128) / 256)
                .truncatingRemainder(dividingBy: 1),
            
            green: ((CGFloat(getByte(index: 1)) + 128) / 256)
                .truncatingRemainder(dividingBy: 1),
            
            blue : ((CGFloat(getByte(index: 2)) + 128) / 256)
                .truncatingRemainder(dividingBy: 1),
            
            alpha: 1
        ).cgColor;
        
    }
    
}
