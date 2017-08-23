//
//  RatingTextAttachment.swift
//  WLTest
//
//  Created by Jordan Perry on 8/21/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Text attachment class designed for allowing the rating stars to be used within an attributed string
class RatingTextAttachment: NSTextAttachment {
    
    /// Font descender, used so that image can be used inline
    let fontDescender: CGFloat
    
    /// the rating
    let rating: Double
    
    /// the max rating
    let maxRating: Int
    
    /// each star's size, where # of stars is equal to maxRating
    let starSize: CGSize
    
    /// each star's background color
    let starBackground: UIColor?
    
    /// each star's foreground color
    let starForeground: UIColor?
    
    /// initialization
    ///
    /// - Parameters:
    ///   - fontDescender: the font descender from the font (UIFont fontDescender property)
    ///   - rating: the rating
    ///   - maxRating: the max rating
    ///   - starSize: each star's size
    ///   - starBackground: each star's background color
    ///   - starForeground: each star's foreground color
    init(fontDescender: CGFloat, rating: Double, maxRating: Int, starSize: CGSize, starBackground: UIColor? = nil, starForeground: UIColor? = nil) {
        self.fontDescender = fontDescender
        self.rating = rating
        self.maxRating = maxRating
        self.starSize = starSize
        self.starBackground = starBackground
        self.starForeground = starForeground
        
        super.init(data: nil, ofType: nil)
        
        image = ratingImage()
    }
    
    /// Helper to get the image from a star view
    ///
    /// - Returns: image of star views
    func ratingImage() -> UIImage? {
        guard let background = starBackground, let foreground = starForeground else {
            return StarView.ratingRow(numberOfStars: maxRating, rating: rating, sizePerStar: starSize)
        }
        
        return StarView.ratingRow(numberOfStars: maxRating, rating: self.rating, sizePerStar: starSize, starBackground: background, starForeground: foreground)
    }
    
    // no xibs here, so no worthwhile implementation needed
    required init?(coder aDecoder: NSCoder) {
        self.fontDescender = 0.0
        self.rating = 0.0
        self.maxRating = 0
        self.starSize = .zero
        self.starBackground = nil
        self.starForeground = nil
        
        super.init(coder: aDecoder)
    }
    
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        guard let image = image else {
            return super.attachmentBounds(for: textContainer, proposedLineFragment: lineFrag, glyphPosition: position, characterIndex: charIndex)
        }
        
        let height = lineFrag.size.height
        var scale: CGFloat = 1.0
        let imageSize = image.size
        
        if height < imageSize.height {
            scale = height / imageSize.height
        }
        
        return CGRect(x: 0.0, y: fontDescender, width: imageSize.width * scale, height: imageSize.height * scale)
    }
}
