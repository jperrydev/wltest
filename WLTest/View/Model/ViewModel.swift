//
//  ViewModel.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

/// Easy protocol used for setting up a view model
protocol ViewModel {
    
    /// Allow for easy setup of what the view model's associated model type will be
    associatedtype T
    
    /// the associated model
    var model: T? { get set }
    
    /// initialize view model with an instance of its associated model type
    ///
    /// - Parameter model: instance of associated model type
    init(with model: T)
    
    /// update view model with an instance of its associated model type
    ///
    /// - Parameter model: instance of associated model type
    func update(with model: T)
}
