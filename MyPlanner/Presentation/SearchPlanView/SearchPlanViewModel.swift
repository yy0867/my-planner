//
//  SearchPlanViewModel.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/13.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchPlanViewModelInput {
    
    var searchText: PublishRelay<String> { get }
    var searchColor: PublishRelay<Plan.Color> { get }
    
    func takeAction(_ action: SearchPlanViewAction)
}

protocol SearchPlanViewModelAction {
    
    var actionRelay: PublishRelay<SearchPlanViewAction> { get }
}

protocol SearchPlanViewModelOutput {
    
    var searchResult: BehaviorRelay<[Plan]> { get }
    
    func getColor(at index: Int) -> Plan.Color
    func getDate(at index: Int) -> Date
    func getName(at index: Int) -> String
    func getAchieve(at index: Int) -> Bool
    func getColorAssets() -> [String]
}

protocol SearchPlanViewModel: SearchPlanViewModelInput,
                              SearchPlanViewModelAction,
                              SearchPlanViewModelOutput { }

class DefaultSearchPlanViewModel: SearchPlanViewModel {
    
    // MARK: - Properties
    let fetchPlanListUseCase: FetchPlanListUseCase
    let planListViewModel: PlanListViewModel
    
    let searchText = PublishRelay<String>()
    let searchColor = PublishRelay<Plan.Color>()
    let searchResult = BehaviorRelay<[Plan]>(value: [])
    let actionRelay = PublishRelay<SearchPlanViewAction>()
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(fetchPlanListUseCase: FetchPlanListUseCase,
         planListViewModel: PlanListViewModel) {
        self.fetchPlanListUseCase = fetchPlanListUseCase
        self.planListViewModel = planListViewModel
        
        bind()
    }
    
    private func bind() {
        
        bindSearchByText()
        bindSearchByColor()
    }
    
    private func bindSearchByText() {
        
        searchText
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] text in
            guard let strongSelf = self else { return }
            print(text)
            strongSelf.fetchPlanListUseCase.execute(name: text) { plans in
                strongSelf.acceptSearchPlans(plans)
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindSearchByColor() {
        
        searchColor.subscribe(onNext: { [weak self] color in
            guard let strongSelf = self else { return }
            strongSelf.fetchPlanListUseCase.execute(color: color) { plans in
                strongSelf.acceptSearchPlans(plans)
            }
        }).disposed(by: disposeBag)
    }
    
    private func acceptSearchPlans(_ plans: [Plan]) {
        searchResult.accept(plans)
    }
    
    public func takeAction(_ action: SearchPlanViewAction) {
        actionRelay.accept(action)
    }
    
    public func getColor(at index: Int) -> Plan.Color {
        return searchResult.value[index].color
    }
    
    public func getDate(at index: Int) -> Date {
        return searchResult.value[index].date
    }
    
    public func getName(at index: Int) -> String {
        return searchResult.value[index].name
    }
    
    public func getAchieve(at index: Int) -> Bool {
        return searchResult.value[index].achieve
    }
    
    public func getColorAssets() -> [String] {
        return Color.getColorAssets()
    }
}
