//
//  ViewModelTests.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import XCTest
@testable import WLTest

class ViewModelTests: XCTestCase {
    var productItemViewModel: ProductItemViewModel?
    
    override func setUp() {
        if let jsonObj = JSONHelper.serialize(with: JSONHelper.testCompleteJson),
            let plpModel = ProductListPageModel(with: jsonObj),
            let product = plpModel.products?.first  {
            productItemViewModel = ProductItemViewModel(with: product)
        }
    }
    
    func testDisplayProductName() {
        guard let displayProductName = productItemViewModel?.displayProductName else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(displayProductName == "VIZIO Class Full-Array LED Smart TV")
    }
    
    func testDisplayPrice() {
        guard let displayPrice = productItemViewModel?.displayPrice else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(displayPrice == "$878.00")
    }
}
