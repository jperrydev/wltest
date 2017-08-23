//
//  ModelTests.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import XCTest
@testable import WLTest

class ModelTests: XCTestCase {
    var plpModel: ProductListPageModel?
    
    override func setUp() {
        if let jsonObj = JSONHelper.serialize(with: JSONHelper.testCompleteJson) {
            plpModel = ProductListPageModel(with: jsonObj)
        }
    }
    
    override func tearDown() {
        plpModel = nil
    }
    
    // MARK: Serialization
    
    func testSerialization() {
        XCTAssert(plpModel != nil)
    }
    
    func testBadDataSerialization() {
        if let jsonObj = JSONHelper.serialize(with: JSONHelper.invalidJson) {
            XCTAssert(ProductListPageModel(with: jsonObj) == nil)
        }
    }
    
    // MARK: Test variable setting
    
    func testPageNumberSet() {
        XCTAssert(plpModel?.pageNumber != nil)
    }
    
    func testPageSizeSet() {
        XCTAssert(plpModel?.pageSize != nil)
    }
    
    func testProductsSet() {
        XCTAssert(plpModel?.products != nil)
    }
    
    func testTotalProductsSet() {
        XCTAssert(plpModel?.totalProducts != nil)
    }
    
    func testStatusSet() {
        XCTAssert(plpModel?.status != nil)
    }
    
    // MARK: Test variable values
    
    func testPageNumberValue() {
        // make sure pageNumber exists
        guard let pageNumber = plpModel?.pageNumber else {
            XCTAssert(false)
            return
        }
        
        // validate pageNumber
        XCTAssert(pageNumber == 1)
    }
    
    func testPageSizeValue() {
        // make sure pageSize exists
        guard let pageSize = plpModel?.pageSize else {
            XCTAssert(false)
            return
        }
        
        // validate pageSize
        XCTAssert(pageSize == 1)
    }
    
    func testProductsValue() {
        // make sure products exist
        guard let products = plpModel?.products else {
            XCTAssert(false)
            return
        }
        
        // make sure products count is 1 and has variables
        guard products.count == 1,
            let product = products.first,
            let productId = product.productId,
            let productName = product.productName,
            let shortDescription = product.shortDescription,
            let longDescription = product.longDescription,
            let price = product.price,
            let productImage = product.productImage,
            let reviewRating = product.reviewRating,
            let reviewCount = product.reviewCount,
            let inStock = product.inStock
            else {
                XCTAssert(false)
                return
        }
        
        // validate variables
        XCTAssert(productId == "31e1cb21-5504-4f02-885b-8f267131a93f")
        XCTAssert(productName == "VIZIO Class Full-Array LED Smart TV")
        XCTAssert(shortDescription == JSONHelper.evaluatedShortDescription)
        XCTAssert(longDescription == JSONHelper.evaluatedLongDescription)
        XCTAssert(price == "$878.00")
        XCTAssert(productImage == URL(string: "http://someurl/0084522601078_A")!)
        XCTAssert(reviewRating == 0.0)
        XCTAssert(reviewCount == 0)
        XCTAssert(inStock)
    }
    
    func testTotalProductsValue() {
        // make sure totalProducts exists
        guard let totalProducts = plpModel?.totalProducts else {
            XCTAssert(false)
            return
        }
        
        // validate totalProducts
        XCTAssert(totalProducts == 342)
    }
    
    func testStatusValue() {
        // make sure status exists
        guard let status = plpModel?.status else {
            XCTAssert(false)
            return
        }
        
        // validate status
        XCTAssert(status == 200)
    }
}
