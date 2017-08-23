//
//  UILabel+HTML.swift
//  WLTest
//
//  Created by Jordan Perry on 8/21/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Extension that allows setting of a HTML on a label, by utilizing NSAttributedString
extension UILabel {
    
    /// set the HTML on a label
    ///
    /// - Parameter string: the html
    func setHTML(_ string: String?) {
        if var html = string {
            html += "<style>body{font-family: '\(font.fontName)'; font-size: \(font.pointSize)px; color: \(textColor.toHexString());}</style>"
            if let data = html.data(using: .utf8) {
                do {
                    let attributed = try NSMutableAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).mutableCopy() as! NSMutableAttributedString
                    // trim bullet's leading tabs for more control over layout
                    attributed.mutableString.replaceOccurrences(of: "\t•\t", with: "•\t", options: .caseInsensitive, range: NSMakeRange(0, attributed.string.characters.count))
                    
                    attributedText = attributed
                } catch {
                    text = nil
                    attributedText = nil
                }
            }
        } else {
            text = nil
            attributedText = nil
        }
    }
}
