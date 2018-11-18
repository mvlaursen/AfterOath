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
        let jsonData = DataFetchSimulator.shared.dataRecordsAsJSON()
        
        XCTAssert(jsonData != nil)
        if let jsonDataUnwrapped = jsonData {
            if let json = try? JSONSerialization.jsonObject(with: jsonDataUnwrapped) {
                if let dataRecords = json as? [DataFetchSimulator.DataRecord] {
                    XCTAssert(dataRecords.count == 20)
                    XCTAssert(dataRecords[0]["thumbnail"] == "https://i.pinimg.com/originals/a4/eb/a5/a4eba5a87811eef3e5e17fbeb606703e.jpg")
                    XCTAssert(dataRecords[0]["hfs"] == "https://www.radiantmediaplayer.com/media/bbb-360p.mp4")
                }
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
