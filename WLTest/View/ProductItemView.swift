//
//  ProductItemView.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// View for displaying a product item
class ProductItemView: UIView, View {
    
    /// set associated view model type
    typealias T = ProductItemViewModel
    
    /// redeclaration of view model variable
    var viewModel: ProductItemViewModel?
    
    /// width for view, defaults to 150.0
    var width: CGFloat = 150.0
    
    /// view for displaying the product's image
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    /// label for displaying the product's price
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor(hex: 0x1175b6)
        
        return label
    }()
    
    /// label for displaying the product's name
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        
        return label
    }()
    
    /// label for displaying the product's rating
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        
        return label
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
        backgroundColor = UIColor.white
        clipsToBounds = true
        
        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(productNameLabel)
        addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8.0),
            productNameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            ])
    }
    
    /// Update the view with a view model
    ///
    /// - Parameter viewModel: the view model to update the view with
    func update(with viewModel: ProductItemViewModel?) {
        self.viewModel = viewModel
        
        guard let viewModel = viewModel else {
            imageView.image = nil
            productNameLabel.text = nil
            priceLabel.text = nil
            ratingLabel.attributedText = nil
            
            return
        }
        
        // this gives a desirable effect when the page loads (mostly due to how collection view works under the hood)
        // setting a variable to not do this unnecessarily, though
        if !viewModel.hasLoadedImage {
            self.imageView.alpha = 0.0
        }
        
        viewModel.displayImage { [weak self] (image, error) in
            guard let strongSelf = self,
                let strongViewModel = strongSelf.viewModel else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.imageView.image = image
                strongViewModel.hasLoadedImage = true
                
                UIView.animate(withDuration: 0.3) {
                    strongSelf.imageView.alpha = 1.0
                }
            }
        }
        
        if let productName = viewModel.displayProductName {
            productNameLabel.text = productName
        }
        
        if let price = viewModel.displayPrice {
            priceLabel.text = price
        }
        
        if let rating = viewModel.displayReviewAttributedText(withFont: ratingLabel.font) {
            ratingLabel.attributedText = rating
        }
        
        setNeedsLayout()
    }
}
