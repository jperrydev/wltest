//
//  ProductDetailDescriptionView.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// View for displaying a product's description
class ProductDetailDescriptionView: UIView, View {
    
    /// set the associated view model type
    typealias T = ProductDescriptionViewModel
    
    /// redeclaration of the view model variable
    var viewModel: ProductDescriptionViewModel?
    
    /// label for displaying the product's specs
    lazy var specsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        
        return label
    }()
    
    /// label for displaying the product's description
    lazy var descriptionLabel: UILabel = {
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
        
        addSubview(specsLabel)
        addSubview(descriptionLabel)
        
        var width: CGFloat = 0.0
        if UIApplication.shared.keyWindow?.traitCollection.userInterfaceIdiom == .phone {
            width = UIScreen.main.bounds.width - 50.0
        } else {
            width = 300.0
        }
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            
            specsLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            specsLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            specsLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: specsLabel.bottomAnchor, constant: 8.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            ])
    }
    
    func update(with viewModel: ProductDescriptionViewModel?) {
        self.viewModel = viewModel
        
        guard let viewModel = viewModel else {
            specsLabel.setHTML(nil)
            descriptionLabel.setHTML(nil)
            
            return
        }
        
        specsLabel.setHTML(viewModel.displaySpecs)
        descriptionLabel.setHTML(viewModel.displayDescription)
    }
}
