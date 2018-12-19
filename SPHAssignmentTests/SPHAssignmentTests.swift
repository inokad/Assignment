//
//  SPHAssignmentTests.swift
//  SPHAssignmentTests
//
//  Created by Inoka Dissanayaka on 12/18/18.
//  Copyright © 2018 Inoka Dissanayaka. All rights reserved.
//

import XCTest
@testable import SPHAssignment

class SPHAssignmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCalculateTotalData() {
        let q1 = Quarter(quarter: "Q1", dataUsage: 2.3)
        let q2 = Quarter(quarter: "Q2", dataUsage: 2.2)
        let q3 = Quarter(quarter: "Q4", dataUsage: 2.2)
        let q4 = Quarter(quarter: "Q3", dataUsage: 2.3)
        
        let quarters2008 = [q1, q2, q3, q4]
        
        let year2008 = Year(year: "2008", quarters: quarters2008);
        XCTAssert(year2008.getCalculatedTotlaData() == 9.0)
    }
    
    func testHasDataVolumeReduced() {
        let q1 = Quarter(quarter: "Q1", dataUsage: 2.3)
        let q2 = Quarter(quarter: "Q2", dataUsage: 2.2)
        let q3 = Quarter(quarter: "Q4", dataUsage: 2.2)
        let q4 = Quarter(quarter: "Q3", dataUsage: 2.3)
        
        let quarters2008 = [q1, q2, q3, q4]
        
        let year2008 = Year(year: "2008", quarters: quarters2008);
        
        XCTAssert(year2008.hasDataVolumeReduced())
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
