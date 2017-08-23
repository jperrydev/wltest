//
//  UIColor+Hex.swift
//  WLTest
//
//  Created by Jordan Perry on 8/21/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Extension for UIColor that allows initializing with hex, or retrieving hex form an exiting color
extension UIColor {
    
    /// initialize with a hex int
    ///
    /// - Parameters:
    ///   - hex: hex integer, ex: 0xFFFFFF
    ///   - alpha: the alpha for the color
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat(integerLiteral: (hex >> 16) & 0xFF)
        let green = CGFloat(integerLiteral: (hex >> 8) & 0xFF)
        let blue = CGFloat(integerLiteral: hex & 0xFF)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /// Gets the hex string value from a color
    ///
    /// - Returns: hex as a string
    func toHexString() -> String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let hex: Int = Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255)
        
        return String(format: "#%06x", hex)
    }
}
