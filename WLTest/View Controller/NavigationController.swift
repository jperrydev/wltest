//
//  NavigationController.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if traitCollection.userInterfaceIdiom == .pad {
            return .all
        }
        
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return traitCollection.userInterfaceIdiom == .pad
    }
}
