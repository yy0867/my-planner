//
//  PlanListViewModelTests.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2022/01/03.
//

import XCTest
import RxBlocking
@testable import MyPlanner

class PlanListViewModelTests: XCTestCase {
    
    lazy var planStubs: [Plan] = {
        var plans = [Plan]()
        
        for i in 1...10 {
            plans.append(Plan.stub(id: i,
                                   name: "PlanStub\(i)",
                                   date: Date.createDate(year: 2022, month: 2, day: i),
                                   color: "#FFFFFF",
                                   notification: true,
                                   achieve: false))
        }
        
        return plans
    }()
    
    class MockFetchPlanListUseCase: FetchPlanListUseCase {
        
        let plans: [Plan]
        
        init(plans: [Plan]) {
            self.plans = plans
        }
        
        func execute(date: Date,
                     completion: ([Plan]) -> Void) {
            completion(plans.filter { $0.date == date })
        }
    }
    
    func test_WeekAndPlanListChanges_When_SelectedDateUpdated() {
        // given
        let useCase = MockFetchPlanListUseCase(plans: planStubs)
        let expectation = self.expectation(description: "plan list viewmodel -> fetch success")
        let range: Int = 3 // Range must be 1 ~ 10
        var response: [Plan] = []
        
        // when
        useCase.execute(date: Date.createDate(year: 2022,
                                              month: 2,
                                              day: range)) { plans in
            response = plans
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(response.first!, planStubs[range - 1])
    }
}
