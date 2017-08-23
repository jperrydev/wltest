//
//  ProductListPageModel.swift
//  WLTest
//
//  Created by Jordan Perry on 8/18/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

/// Model used for loading the product list page
struct ProductListPageModel: Requestable {
    
    /// apiKey for the request to fetch the model
    let apiKey: String?
    
    /// pageNumber used for requesting a certain page
    /// *Note*: also gets updated from the response
    let pageNumber: Int?
    
    /// pageSize used for requesting a page with a certain amount of items
    /// *Note*: also gets updated from the response
    let pageSize: Int?
    
    /// list of products
    let products: [ProductItemModel]?
    
    /// total products for current product index
    let totalProducts: Int?
    
    /// status of the request
    let status: Int?
    
    /// initialize with parameters
    ///
    /// - Parameters:
    ///   - apiKey: apiKey for the request to fetch the model
    ///   - pageNumber: pageNumber used for requesting a certain page
    ///   - pageSize: pageSize used for requesting a page with a certain amount of items
    ///   - products: list of products, default nil
    ///   - totalProducts: total products for current product index, default nil
    ///   - status: status of the request, default nil
    init(apiKey: String, pageNumber: Int, pageSize: Int, products: [ProductItemModel]? = nil, totalProducts: Int? = nil, status: Int? = nil) {
        self.apiKey = apiKey
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        
        self.products = products
        self.totalProducts = totalProducts
        self.status = status
    }
    
    init?(with json: Any?) {
        guard let json = json as? [String : Any] else {
            return nil
        }
        
        pageNumber = json["pageNumber"] as? Int
        pageSize = json["pageSize"] as? Int
        
        if let productsData = json["products"] as? [[String : Any]] {
            var productArray: [ProductItemModel] = []
            
            for productData in productsData {
                productArray.append(ProductItemModel(with: productData))
            }
            
            products = productArray
        } else {
            products = nil
        }
        
        totalProducts = json["totalProducts"] as? Int
        status = json["status"] as? Int
        
        apiKey = nil
    }
    
    func route() -> String? {
        guard let apiKey = apiKey, let pageNumber = pageNumber, let pageSize = pageSize else {
            return nil
        }
        
        return "walmartproducts/\(apiKey)/\(pageNumber)/\(pageSize)"
    }
    
    func request(completion: @escaping (ProductListPageModel?, URLResponse?, Error?) -> Void) {
        Networking.shared.loadData(with: self) { (obj, response, error) in
            completion(obj, response, error)
        }
    }
}
