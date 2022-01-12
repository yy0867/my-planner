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
    
    // MARK: - Notification
    func makeNotificationCenter() -> PlanNotificationCenter {
        return DefaultPlanNotificationCenter()
    }
    
    // MARK: - Repository
    func makePlanRepository() -> PlanRepository {
        return DefaultPlanRepository(storage: planRealmStorage,
                                     notificationCenter: makeNotificationCenter())
    }
    
    // MARK: - UseCase
    func makeFetchPlanListByDateUseCase() -> FetchPlanListByDateUseCase {
        return DefaultFetchPlanListByDateUseCase(repository: makePlanRepository())
    }
    
    func makeUpdatePlanUseCase() -> UpdatePlanUseCase {
        return DefaultUpdatePlanUseCase(repository: makePlanRepository())
    }
    
    func makeAddPlanUseCase() -> AddPlanUseCase {
        return DefaultAddPlanUseCase(repository: makePlanRepository())
    }
    
    func makeDeletePlanUseCase() -> DeletePlanUseCase {
        return DefaultDeletePlanUseCase(repository: makePlanRepository())
    }
    
    // MARK: - PlanListView
    func makePlanListViewController() -> PlanListViewController {
        return PlanListViewController(viewModel: makePlanListViewModel(),
                                      addPlanViewControllerFactory: self,
                                      editPlanViewControllerFactory: self)
    }
    
    func makePlanListViewModel() -> PlanListViewModel {
        return DefaultPlanListViewModel(fetchPlanListUseCase: makeFetchPlanListByDateUseCase(),
                                        updatePlanUseCase: makeUpdatePlanUseCase())
    }
}

extension DependencyContainer: AddPlanViewControllerFactory {
    
    // MARK: - AddPlanView
    func makeAddPlanViewController(planListViewModel: PlanListViewModel) -> AddPlanViewController {
        let addPlanViewModel = makeAddPlanViewModel(planListViewModel: planListViewModel)
        return AddPlanViewController(viewModel: addPlanViewModel,
                                     colorSelectorViewController: makeColorSelectorViewController())
    }
    
    func makeAddPlanViewModel(planListViewModel: PlanListViewModel) -> AddPlanViewModel {
        return DefaultAddPlanViewModel(addPlanUseCase: makeAddPlanUseCase(),
                                       planListViewModel: planListViewModel)
    }
}

extension DependencyContainer: EditPlanViewControllerFactory {
    
    // MARK: - EditPlanView
    func makeEditPlanViewController(planListViewModel: PlanListViewModel) -> EditPlanViewController {
        let editPlanViewModel = makeEditPlanViewModel(planListViewModel: planListViewModel)
        return EditPlanViewController(viewModel: editPlanViewModel,
                                      colorSelectorViewController: makeColorSelectorViewController())
    }
    
    func makeEditPlanViewModel(planListViewModel: PlanListViewModel) -> EditPlanViewModel {
        return DefaultEditPlanViewModel(planListViewModel: planListViewModel,
                                        updatePlanUseCase: makeUpdatePlanUseCase(),
                                        deletePlanUseCase: makeDeletePlanUseCase())
    }
}

extension DependencyContainer {
    
    // MARK: - ColorSelectorView
    func makeColorSelectorViewController() -> ColorSelectorViewController {
        let colorSelectorViewModel = makeColorSelectorViewModel()
        return ColorSelectorViewController(viewModel: colorSelectorViewModel)
    }
    
    func makeColorSelectorViewModel() -> ColorSelectorViewModel {
        return DefaultColorSelectorViewModel()
    }
}
