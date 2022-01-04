//
//  Date+DateComponentTests.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2022/01/04.
//

import XCTest
@testable import MyPlanner

class Date_DateComponentTests: XCTestCase {
    
    func testCreateDate() {
        
        let date = Date.createDate(year: 2022,
                                   month: 10,
                                   day: 3,
                                   hour: 10,
                                   minute: 30)
        
        log(date)
        XCTAssertEqual(date.toString(format: "YYYY-M-d"), "2022-10-3")
    }
}
