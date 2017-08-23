//
//  ProductItemModel.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

/// Model used for capturing product item info
class ProductItemModel {
    
    /// product's identifier
    let productId: String?
    
    /// product's name
    let productName: String?
    
    /// product's short description / specs
    let shortDescription: String?
    
    /// product's long description
    let longDescription: String?
    
    /// product's price
    let price: String?
    
    /// product's image url
    let productImage: URL?
    
    /// products review rating (out of 5)
    let reviewRating: Double?
    
    /// product's review count
    let reviewCount: Int?
    
    /// product's indicator of in or out of stock
    let inStock: Bool?
    
    /// weak reference to product item view model (for in-memory caching)
    weak var productItemViewModel: ProductItemViewModel?
    
    /// weak reference to product description view model (for in-memory caching)
    weak var productDescriptionViewModel: ProductDescriptionViewModel?
    
    /// initialize with a dictionary object
    ///
    /// - Parameter data: a dictionary representation, generally intended to be passed along from json
    init(with data: [String : Any]) {
        productId = data["productId"] as? String
        productName = data["productName"] as? String
        shortDescription = data["shortDescription"] as? String
        longDescription = data["longDescription"] as? String
        price = data["price"] as? String
        
        if let productImageString = data["productImage"] as? String {
            productImage = URL(string: productImageString)
        } else {
            productImage = nil
        }
        
        reviewRating = data["reviewRating"] as? Double
        reviewCount = data["reviewCount"] as? Int
        inStock = data["inStock"] as? Bool
    }
}
