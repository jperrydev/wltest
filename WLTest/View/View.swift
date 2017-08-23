//
//  View.swift
//  WLTest
//
//  Created by Jordan Perry on 8/20/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

/// Protocol used to more easily associate a view model to a view
protocol View {
    
    /// Allow for easy setup of what the view's associated view model type will be
    associatedtype T
    
    /// the associated view model
    var viewModel: T? { get set }
    
    /// update view with an instance of its associated view model
    ///
    /// - Parameter viewModel: instance of associated view model
    func update(with viewModel: T?)
}
