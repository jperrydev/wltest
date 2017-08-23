//
//  LoadingCollectionViewCell.swift
//  WLTest
//
//  Created by Jordan Perry on 8/21/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

/// Collection view cell used for signaling a pagination load
class LoadingCollectionViewCell: UICollectionViewCell {
    
    /// indicator used for displaying activity
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = false
        
        return activity
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
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(activityIndicator)
        contentView.addSubview(parentView)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: parentView.layoutMarginsGuide.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: parentView.layoutMarginsGuide.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            parentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100.0),
            
            parentView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            parentView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            parentView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            parentView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
}
