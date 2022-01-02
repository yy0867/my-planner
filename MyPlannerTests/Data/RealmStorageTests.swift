//
//  RealmStorageTests.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import XCTest
@testable import MyPlanner

class RealmStorageTests: XCTestCase {
    
    let mockPlan = Plan.stub(name: "SearchByNameTest",
                             date: .createDate(year: 2022,
                                               month: 1,
                                               day: 3))
    let storage = PlanRealmStorage(dtoMapper: PlanDtoMapper())
    
    // MARK: - Create
    func testRealmCreate() {
        // given
        let dtoCreate = PlanDto.Create(name: mockPlan.name,
                                       date: mockPlan.date,
                                       color: mockPlan.color)
        let expectation = self.expectation(description: "Realm -> Create Success")
        var response: Plan?
        
        // when
        storage.create(dto: dtoCreate) { result in
            switch result {
                case .success(let dtoResult):
                    response = PlanDtoMapper().asModel(dtoResult: dtoResult)
                    expectation.fulfill()
                case .failure(let e):
                    print(e.localizedDescription)
                    expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        log(response)
        XCTAssertNotNil(response)
    }
    
    // MARK: - Search
    func testRealmSearchByName() {
        testRealmSearchBy(dtoSearch: PlanDto.Search(id: nil,
                                                    name: mockPlan.name,
                                                    date: nil))
    }
    
    func testRealmSearchById() {
        testRealmSearchBy(dtoSearch: PlanDto.Search(id: mockPlan.id,
                                                    name: nil,
                                                    date: nil))
    }
    
    func testRealmSearchByDate() {
        let date = Date.createDate(year: 2021,
                                   month: 12,
                                   day: 30)
        
        testRealmSearchBy(dtoSearch: PlanDto.Search(id: nil,
                                                    name: nil,
                                                    date: date))
    }
    
    func testRealmSearchBy(dtoSearch: PlanDto.Search) {
        // given
        let dtoSearch = dtoSearch
        let expectation = self.expectation(description: "Realm search Success")
        var response: [Plan]?
        
        // when
        storage.search(dto: dtoSearch) { result in
            switch result {
                case .success(let dtoResults):
                    response = dtoResults.map { PlanDtoMapper().asModel(dtoResult: $0) }
                    expectation.fulfill()
                case .failure(let e):
                    print(e.localizedDescription)
                    expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        arrayLog(response)
        XCTAssertNotNil(response)
    }
    
    // MARK: - Update
    func testRealmUpdate() {
        
    }
    
    // MARK: - Delete
    func testRealmDelete() {
        
    }
}
