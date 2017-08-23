//
//  ProductDetailInfoView.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// View for displaying the product's info on the product detail view
class ProductDetailInfoView: ProductItemView {
    
    /// Initial setup of the view
    /// Modify variables from superclass is all that is needed
    override func setup() {
        if UIApplication.shared.keyWindow?.traitCollection.userInterfaceIdiom == .phone {
            width = UIScreen.main.bounds.width - 50.0
        } else {
            width = 300.0
        }
        
        priceLabel.font = UIFont.systemFont(ofSize: 20.0)
        productNameLabel.font = UIFont.systemFont(ofSize: 24.0)
        ratingLabel.font = UIFont.systemFont(ofSize: 16.0)
        
        super.setup()
    }
}
