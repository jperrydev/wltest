//
//  ProductDetailDescriptionCollectionViewCell.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Collection view cell that is a simple wrapper around the ProductDetailDescriptionView
class ProductDetailDescriptionCollectionViewCell: UICollectionViewCell {
    
    /// the product detail description view
    lazy var productDetailDescriptionView: ProductDetailDescriptionView = {
        let view = ProductDetailDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    /// Initial setup of the view
    func setup() {
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(productDetailDescriptionView)
        
        NSLayoutConstraint.activate([
            productDetailDescriptionView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            productDetailDescriptionView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            productDetailDescriptionView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            productDetailDescriptionView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
}
