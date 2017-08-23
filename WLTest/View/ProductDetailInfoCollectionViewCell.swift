//
//  ProductDetailInfoCollectionViewCell.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Collection view cell that is a simple wrapper around ProductDetailInfoView
class ProductDetailInfoCollectionViewCell: UICollectionViewCell {
    
    /// the product detail info view
    lazy var productDetailInfoView: ProductDetailInfoView = {
        let view = ProductDetailInfoView()
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
        
        contentView.addSubview(productDetailInfoView)
        
        NSLayoutConstraint.activate([
            productDetailInfoView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            productDetailInfoView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            productDetailInfoView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            productDetailInfoView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
    }
}
