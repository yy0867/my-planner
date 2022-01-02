//
//  FetchPlanListByDateUseCase.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2021/12/31.
//

import Foundation
import XCTest
@testable import MyPlanner

class FetchPlanListByDateUseCaseTests: XCTestCase {
    
    let repository: DefaultPlanRepository = {
        let dtoMapper = PlanDtoMapper()
        let storage = PlanRealmStorage(dtoMapper: dtoMapper)
        return DefaultPlanRepository(storage: storage)
    }()
    
    func testExecute() {
        // given
        let useCase = FetchPlanListByDateUseCase(repository: repository)
        let date = Date.createDate(year: 2022,
                                   month: 1,
                                   day: 3)
        let expectation = self.expectation(description: "fetchPlanList execute success")
        var response: [Plan] = []
        
        // when
        useCase.execute(date: date) { plans in
            response = plans
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        arrayLog(response)
        XCTAssertFalse(response.isEmpty)
    }
}
