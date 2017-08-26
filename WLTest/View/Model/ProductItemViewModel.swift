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
    static var currentOperations: [URL: NSHashTable<AsyncBlockOperation>] = [:]
    
    /// cache of images, based on url
    static var cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()
    
    /// set associated model type
    typealias T = ProductItemModel
    
    /// redeclare variable for associated model type
    var model: ProductItemModel?
    
    /// Can be used by an image to cache whether or not the image has been loaded visually
    var hasLoadedImage: Bool = false
    
    /// Current operation for view model
    var currentOperation: AsyncBlockOperation?
    
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
        
        let op = AsyncBlockOperation { (cancelled, finished) in
            if let image = ProductItemViewModel.cache.object(forKey: imageURL as NSURL) {
                guard !cancelled() else {
                    return
                }
                
                completion(image, nil)
                finished()
            } else {
                Networking.shared.loadData(with: imageURL) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.global().async {
                            if let image = UIImage(data: data) {
                                ProductItemViewModel.cache.setObject(image, forKey: imageURL as NSURL)
                                // even if cancelled, let's save to cache :)
                                guard !cancelled() else {
                                    return
                                }
                                
                                completion(image, nil)
                            } else {
                                guard !cancelled() else {
                                    return
                                }
                                
                                completion(nil, nil)
                            }
                        }
                    } else {
                        guard !cancelled() else {
                            return
                        }
                        
                        completion(nil, error)
                    }
                    
                    finished()
                }
            }
        }
        
        if let hash = ProductItemViewModel.currentOperations[imageURL] {
            if let lastOp = hash.allObjects.last {
                op.addDependency(lastOp)
            }
            
            hash.add(op)
        } else {
            let hash = NSHashTable<AsyncBlockOperation>.weakObjects()
            hash.add(op)
            
            ProductItemViewModel.currentOperations[imageURL] = hash
        }
        
        OperationQueue.main.addOperation(op)
    }
    
    func cancelImageDownload() {
        guard let currentOperation = currentOperation else {
            return
        }
        
        currentOperation.cancel()
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
