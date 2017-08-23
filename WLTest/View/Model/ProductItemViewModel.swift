//
//  ProductItemViewModel.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation
import UIKit

/// View model used for displaying a product item view
class ProductItemViewModel: ViewModel {
    
    /// imageCompletion typealias for easy reuse
    typealias imageCompletion = (UIImage?, Error?) -> Swift.Void
    
    /// keep track of current requests to avoid ignoring cache
    static var currentRequests: [URL : [imageCompletion]] = [:]
    
    /// cache of images, based on url
    static var cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()
    
    /// set associated model type
    typealias T = ProductItemModel
    
    /// redeclare variable for associated model type
    var model: ProductItemModel?
    
    /// Can be used by an image to cache whether or not the image has been loaded visually
    var hasLoadedImage: Bool = false
    
    /// how the product name should be displayed
    var displayProductName: String? {
        return model?.productName
    }
    
    /// how the price should be displayed
    var displayPrice: String? {
        return model?.price
    }
    
    /// Fetch the attributed string for how the product's rating should be displayed
    ///
    /// - Parameter font: The font for the label this will be a part of
    /// - Returns: NSAttributedString, preformatted to have review stars inline and the correct size
    func displayReviewAttributedText(withFont font: UIFont) -> NSAttributedString? {
        guard let reviewRating = model?.reviewRating, let reviewCount = model?.reviewCount else {
            return nil
        }
        
        let attrString = NSMutableAttributedString()
        
        let ratingAttachment = RatingTextAttachment(fontDescender: font.descender + 1, rating: reviewRating, maxRating: 5, starSize: CGSize(width: font.pointSize, height: font.pointSize), starBackground: UIColor.gray, starForeground: UIColor(hex: 0xfbba41))
        attrString.append(NSAttributedString(attachment: ratingAttachment))
        
        attrString.append(NSAttributedString(string: " (\(reviewCount))"))
        
        return attrString as NSAttributedString
    }
    
    /// Load image so that it can be displayed
    ///
    /// - Parameter completion: handler for when the image request has completed
    func displayImage(completion: @escaping imageCompletion) {
        guard let imageURL = model?.productImage else {
            completion(nil, nil)
            return
        }
        
        if let image = ProductItemViewModel.cache.object(forKey: imageURL as NSURL) {
            completion(image, nil)
            return
        }
        
        if var currentRequests = ProductItemViewModel.currentRequests[imageURL], currentRequests.count > 0 {
            currentRequests.append(completion)
        } else {
            if var currentRequests = ProductItemViewModel.currentRequests[imageURL] {
                currentRequests.append(completion)
            } else {
                ProductItemViewModel.currentRequests[imageURL] = [completion]
            }
            
            Networking.shared.loadData(with: imageURL) { (data, response, error) in
                var existingRequests: [imageCompletion] = []
                if var currentRequests = ProductItemViewModel.currentRequests[imageURL] {
                    existingRequests.append(contentsOf: currentRequests)
                    currentRequests.removeAll()
                }
                
                if let data = data {
                    DispatchQueue.global().async {
                        if let image = UIImage(data: data) {
                            ProductItemViewModel.cache.setObject(image, forKey: imageURL as NSURL)
                            DispatchQueue.main.async {
                                self.fireAllHandlers(imageURL, image, nil, existingRequests)
                            }
                        } else {
                            self.fireAllHandlers(imageURL, nil, nil, existingRequests)
                        }
                    }
                } else {
                    self.fireAllHandlers(imageURL, nil, error, existingRequests)
                }
            }
        }
    }
    
    /// Helper for firing all handlers that are currently cached for a url
    ///
    /// - Parameters:
    ///   - imageURL: The imageURL used for fetching the image
    ///   - image: The image
    ///   - error: Any error for the request
    ///   - existingRequests: The existing request handlers
    func fireAllHandlers(_ imageURL: URL, _ image: UIImage?, _ error: Error?, _ existingRequests: [imageCompletion]) {
        for handler in existingRequests {
            handler(image, error)
        }
    }
    
    /// initialize with model
    ///
    /// - Parameter model: product item model
    required init(with model: ProductItemModel) {
        update(with: model)
    }
    
    /// update with model
    ///
    /// - Parameter model: product item model
    func update(with model: ProductItemModel) {
        self.model = model
        
        model.productItemViewModel = self
    }
}
