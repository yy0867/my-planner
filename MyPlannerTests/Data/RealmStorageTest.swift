//
//  RealmPlanListFetchStorageTest.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import XCTest
@testable import MyPlanner

class RealmStorageTest: XCTestCase {
    
    func testSaveData() {
        // given
        let plan = Plan.stub()
        let realmSavePlanStorage = RealmSavePlanStorage()
        let expectation = self.expectation(description: "realm save plan success.")
        var response: Plan?
        
        // when
        print(plan.asRealmObject())
        realmSavePlanStorage.savePlan(plan.asRealmObject()) { result in
            switch result {
                case .success(let plan):
                    response = plan
                    expectation.fulfill()
                case .failure(let error):
                    print(error.localizedDescription)
                    expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(response)
    }
    
    func testFetchData() {
        // given
        let query: (PlanEntity) -> Bool = { planEntity in
            planEntity.name == "PlanName"
        }
        let realmPlanListFetchStorage = RealmPlanListFetchStorage()
        let expectation = self.expectation(description: "realm fetch data success.")
        var response: [Plan] = []
        
        // when
        realmPlanListFetchStorage.fetchPlanList(by: query) { result in
            switch result {
                case .success(let plans):
                    response = plans
                    expectation.fulfill()
                case .failure(let error):
                    print(error.localizedDescription)
                    expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(response.isEmpty)
    }
}
