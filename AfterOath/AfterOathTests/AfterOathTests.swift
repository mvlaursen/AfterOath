//
//  AfterOathTests.swift
//  AfterOathTests
//
//  Created by Mike Laursen on 11/18/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import XCTest

class AfterOathTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jsonData = DataFetchSimulator.shared.dataRecordsAsJSON()
        XCTAssert(jsonData != nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
