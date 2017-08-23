//
//  RequestableTests.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import XCTest
@testable import WLTest

class RequestableTestObject: Requestable {
    let intVariable: Int?
    let boolVariable: Bool?
    let stringVariable: String?
    let doubleVariable: Double?
    let stringArrayVariable: [String]?
    
    let int2Variable: Int?
    let bool2Variable: Bool?
    let string2Variable: String?
    let double2Variable: Double?
    let string2ArrayVariable: [String]?
    
    let incorrectType: String?
    
    init() {
        intVariable = nil
        boolVariable = nil
        stringVariable = nil
        doubleVariable = nil
        stringArrayVariable = nil
        
        int2Variable = nil
        bool2Variable = nil
        string2Variable = nil
        double2Variable = nil
        string2ArrayVariable = nil
        
        incorrectType = nil
    }
    
    typealias T = RequestableTestObject
    
    func route() -> String? {
        return nil
    }
    
    func request(completion: @escaping (RequestableTestObject?, URLResponse?, Error?) -> Swift.Void) {
        completion(nil, nil, nil)
    }
    
    required init?(with json: Any?) {
        guard let json = json as? [String : Any] else {
            return nil
        }
        
        intVariable = json["int"] as? Int
        boolVariable = json["bool"] as? Bool
        stringVariable = json["string"] as? String
        doubleVariable = json["double"] as? Double
        stringArrayVariable = json["stringArray"] as? [String]
        
        int2Variable = json["int2"] as? Int
        bool2Variable = json["bool2"] as? Bool
        string2Variable = json["string2"] as? String
        double2Variable = json["double2"] as? Double
        string2ArrayVariable = json["stringArray2"] as? [String]
        
        incorrectType = json["incorrectType"] as? String
    }
}

class RequestableTests: XCTestCase {
    let stubJson: [String : Any] = ["int": 1, "bool": true, "string": "test", "double": 1.0, "stringArray": [""], "incorrectType": 1]
    var obj: RequestableTestObject?
    
    override func setUp() {
        obj = RequestableTestObject(with: stubJson)
    }
    
    func testInt() {
        XCTAssert(obj?.intVariable != nil)
    }
    
    func testBool() {
        XCTAssert(obj?.boolVariable != nil)
    }
    
    func testString() {
        XCTAssert(obj?.stringVariable != nil)
    }
    
    func testDouble() {
        XCTAssert(obj?.doubleVariable != nil)
    }
    
    func testStringArray() {
        XCTAssert(obj?.stringArrayVariable != nil)
    }
    
    func testNilInt() {
        XCTAssert(obj?.int2Variable == nil)
    }
    
    func testNilBool() {
        XCTAssert(obj?.bool2Variable == nil)
    }
    
    func testNilString() {
        XCTAssert(obj?.string2Variable == nil)
    }
    
    func testNilDouble() {
        XCTAssert(obj?.double2Variable == nil)
    }
    
    func testNilStringArray() {
        XCTAssert(obj?.string2ArrayVariable == nil)
    }
    
    func testIncorrectType() {
        XCTAssert(obj?.incorrectType == nil)
    }
}
