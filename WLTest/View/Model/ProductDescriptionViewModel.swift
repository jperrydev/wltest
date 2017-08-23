//
//  ProductDescriptionViewModel.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

/// View model used for displaying a product description view
class ProductDescriptionViewModel: ViewModel {
    
    /// set associated model type
    typealias T = ProductItemModel
    
    /// redeclare variable for associated model type
    var model: ProductItemModel?
    
    /// how the specs should be displayed
    var displaySpecs: String? {
        guard let shortDescription = model?.shortDescription else {
            return nil
        }
        
        return "<h3>Specs</h3>\n\(shortDescription)"
    }
    
    /// how the description should be displayed
    var displayDescription: String? {
        guard let longDescription = model?.longDescription else {
            return nil
        }
        
        return "<h3>Description</h3>\n\(longDescription)"
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
        
        model.productDescriptionViewModel = self
    }
}
