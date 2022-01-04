//
//  DIContainer.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//

import Foundation

class DependencyContainer {
    
    // MARK: - DTO Mapper
    let planDtoMapper = PlanDtoMapper()
    
    // MARK: - Persistent Storage
    lazy var planRealmStorage: Storage = PlanRealmStorage(dtoMapper: planDtoMapper)
    
    
    // MARK: - UseCase
    func makeFetchPlanListByDateUseCase() -> FetchPlanListByDateUseCase {
        return DefaultFetchPlanListByDateUseCase(repository: makePlanRepository())
    }
    
    // MARK: - Repository
    func makePlanRepository() -> PlanRepository {
        return DefaultPlanRepository(storage: planRealmStorage)
    }
    
    // MARK: - PlanListView
    func makePlanListViewController() -> PlanListViewController {
        return PlanListViewController(viewModel: makePlanListViewModel())
    }
    
    func makePlanListViewModel() -> PlanListViewModel {
        return DefaultPlanListViewModel(fetchPlanListUseCase: makeFetchPlanListByDateUseCase())
    }
}
