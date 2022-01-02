//
//  RealmRepositoryTests.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import XCTest
@testable import MyPlanner

class PlanRepositoryTests: XCTestCase {
    
    let storage = PlanRealmStorage(dtoMapper: PlanDtoMapper())
    let mockPlan = Plan.stub(name: "PlanRepositoryTestMock",
                             date: Date(),
                             color: "#3F34A2",
                             notification: true,
                             achieve: false)
    
    // MARK: - Create
    func testPlanRepositoryCreate() {
        // given
        let planRepository = DefaultPlanRepository(storage: storage)
        let createDto = PlanDto.Create(name: mockPlan.name,
                                       date: mockPlan.date,
                                       color: mockPlan.color)
        let expectation = self.expectation(description: "plan repository create success")
        var response: Plan?
        
        // when
        planRepository.create(dto: createDto) { result in
            switch result {
                case .success(let plan):
                    response = plan
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
    func testPlanRepositorySearch(by searchDto: PlanDto.Search) {
        // given
        let planRepository = DefaultPlanRepository(storage: storage)
        let searchDto = searchDto
        let expectation = self.expectation(description: "plan repository search success")
        var response: [Plan]?
        
        // when
        planRepository.search(dto: searchDto) { result in
            switch result {
                case .success(let plans):
                    response = plans
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
    
    func testPlanRepositorySearchByName() {
        let searchDto = PlanDto.Search(id: nil,
                                       name: "SearchByNameTest",
                                       date: nil)
        
        testPlanRepositorySearch(by: searchDto)
    }
    
    func testPlanRepositorySearchById() {
        let searchDto = PlanDto.Search(id: 3,
                                       name: nil,
                                       date: nil)
        
        testPlanRepositorySearch(by: searchDto)
    }
    
    func testPlanRepositorySearchByDate() {
        let date = Date.createDate(year: 2021,
                                   month: 12,
                                   day: 30)
        
        let searchDto = PlanDto.Search(id: nil,
                                       name: nil,
                                       date: date)
        
        testPlanRepositorySearch(by: searchDto)
    }
    
    // MARK: - Update
    func testPlanRepositoryUpdate() {
        
    }
    
    // MARK: - Delete
    func testPlanRepositoryDelete() {
        
    }
}
