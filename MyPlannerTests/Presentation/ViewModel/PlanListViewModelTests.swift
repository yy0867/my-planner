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

    func test_WeekAndPlanListChanges_When_SelectedDateUpdated() {
        // given
        let storage = PlanRealmStorage(dtoMapper: PlanDtoMapper())
        let repository = DefaultPlanRepository(storage: storage)
        let useCase = FetchPlanListByDateUseCase(repository: repository)
        
        let expectation = self.expectation(description: "update data by selectedDate success.")
        let viewModel = DefaultPlanListViewModel(fetchPlanListUseCase: useCase)
        let date = Date.createDate(year: 2021, month: 12, day: 30)
        
        // when
        viewModel.changeDate(date: date) {
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(date.toString(), viewModel.selectedDate.value.toString())
        arrayLog(viewModel.planList.value)
        arrayLog(viewModel.week.value)
        log(viewModel.selectedDate.value)
    }
}
