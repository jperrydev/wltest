//
//  StarView.swift
//  WLTest
//
//  Created by Jordan Perry on 8/21/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit
import QuartzCore

/// Drawing of a star to be used for rating
class StarView: UIView {
    
    /// Star's background color, default UIColor.gray
    var starBackground: UIColor = UIColor.gray
    
    /// Star's foreground color, default UIColor.yellow
    var starForeground: UIColor = UIColor.yellow
    
    /// the star's fill type
    ///
    /// - empty: no fill
    /// - half: fill half, starting from left (notes: in RTL languages, this would need to support the opposite. currently does not.)
    /// - full: full fill
    enum StarFill: Int {
        case empty = 0
        case half = 1
        case full = 2
    }
    
    /// the star's fill, default StarFill.empty
    var starFill: StarFill = .empty
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pointsOnStar = 5
        let excursion: CGFloat = rect.width / CGFloat(pointsOnStar)
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        
        var angle = -CGFloat(Double.pi / 2.0)
        
        let increment = CGFloat(Double.pi * 2.0 / Double(pointsOnStar))
        let radius = rect.width / 2.0
        
        let path = UIBezierPath()
        
        func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
            return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
        }
        
        var points: [CGPoint] = []
        for i in 1...pointsOnStar {
            let point = pointFrom(angle: angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle: angle + increment, radius: radius, offset: center)
            let midPoint = pointFrom(angle: angle + increment / 2.0, radius: excursion, offset: center)
            
            points.append(point)
            points.append(midPoint)
            
            if i == 1 {
                path.move(to: point)
            }
            
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            
            angle += increment
        }
        
        path.close()
        
        if starFill == .full {
            starForeground.setFill()
        } else {
            starBackground.setFill()
        }
        
        path.fill()
        
        if starFill == .half {
            let halfPath = UIBezierPath()
            
            var firstX: CGFloat?
            var secondX: CGFloat?
            for point in points {
                if firstX == nil {
                    firstX = point.x
                    halfPath.move(to: point)
                    continue
                }
                
                if firstX! == point.x {
                    secondX = point.x
                }
                
                if secondX == nil {
                    continue
                }
                
                halfPath.addLine(to: point)
            }
            
            halfPath.close()
            
            starForeground.setFill()
            
            halfPath.fill()
        }
    }
    
    /// cache the images so that unnecessary redrawing does not take place
    static var cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    /// Returns a row of stars used for what would be a rating
    ///
    /// - Parameters:
    ///   - numberOfStars: the number of stars in the row
    ///   - rating: the current rating
    ///   - sizePerStar: size per star
    ///   - starBackground: each star's background
    ///   - starForeground: each star's foreground
    /// - Returns: an image of the stars in a row with the rating filled
    static func ratingRow(numberOfStars: Int, rating: Double, sizePerStar: CGSize, starBackground: UIColor = UIColor.gray, starForeground: UIColor = UIColor.yellow) -> UIImage? {
        let cacheString = "\(numberOfStars),\(rating),\(sizePerStar),\(starBackground.toHexString()),\(starForeground.toHexString())" as NSString
        if let existingImage = cache.object(forKey: cacheString) {
            return existingImage
        }
        
        let parentView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sizePerStar.width * CGFloat(numberOfStars), height: sizePerStar.height))
        parentView.backgroundColor = UIColor.clear
        
        var currentRating = rating
        for i in 0..<numberOfStars {
            let starView = StarView(frame: CGRect(x: CGFloat(i) * sizePerStar.width, y: 0.0, width: sizePerStar.width, height: sizePerStar.height))
            starView.starBackground = starBackground
            starView.starForeground = starForeground
            
            if currentRating >= 1.0 {
                starView.starFill = .full
                
                currentRating -= 1.0
            } else if currentRating > 0.0 {
                starView.starFill = .half
                
                currentRating = 0.0
            } else {
                starView.starFill = .empty
            }
            
            parentView.addSubview(starView)
        }
        
        UIGraphicsBeginImageContextWithOptions(parentView.frame.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            parentView.layer.render(in: context)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            if let img = image {
                cache.setObject(img, forKey: cacheString)
            }
            
            return image
        }
        
        return nil
    }
}
