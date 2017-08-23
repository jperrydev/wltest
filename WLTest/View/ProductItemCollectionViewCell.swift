//
//  ProductItemCollectionViewCell.swift
//  WLTest
//
//  Created by Jordan Perry on 8/20/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Collection view cell that is a simple wrapper around the ProductItemView
class ProductItemCollectionViewCell: UICollectionViewCell {
    
    /// the product item view
    lazy var productItemView: ProductItemView = {
        let productItemView = ProductItemView()
        productItemView.translatesAutoresizingMaskIntoConstraints = false
        
        return productItemView
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
        
        contentView.addSubview(productItemView)
        
        NSLayoutConstraint.activate([
            productItemView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            productItemView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            productItemView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            productItemView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productItemView.update(with: nil)
    }
}
