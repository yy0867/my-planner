//
//  PlanListViewModel.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/31.
//

import Foundation
import RxSwift
import RxRelay

protocol PlanListViewModelInput {
    
    func changeDate(date: Date)
    func togglePlanAchieve(at index: Int)
}

@objc
protocol PlanListViewModelAction {
    
    @objc func presentProfile()
    @objc func presentDateSelector()
    @objc func presentAddPlan()
    @objc func presentSearchPlan()
}

protocol PlanListViewModelOutput {
    
    var touchAction: PublishSubject<PlanListTitleBarAction> { get }
    var selectedDate: BehaviorRelay<Date> { get }
//    var week: BehaviorRelay<[Date]> { get }
    var planList: BehaviorRelay<[Plan]> { get }
    var disposeBag: DisposeBag { get }
    
    func getTimeLineMode(at index: Int) -> PlanListCell.TimeLineMode
    func getPlan(at index: Int) -> Plan
}

protocol PlanListViewModel: PlanListViewModelInput,
                            PlanListViewModelOutput,
                            PlanListViewModelAction { }

final class DefaultPlanListViewModel: PlanListViewModel {
    
    // MARK: - Properties
    private let fetchPlanListUseCase: FetchPlanListByDateUseCase
    private let updatePlanUseCase: UpdatePlanUseCase
    
    init(fetchPlanListUseCase: FetchPlanListByDateUseCase,
         updatePlanUseCase: UpdatePlanUseCase) {
        self.fetchPlanListUseCase = fetchPlanListUseCase
        self.updatePlanUseCase = updatePlanUseCase
        
        bindOutputToSelectedDate()
    }
    
    // MARK: - Methods
    private func bindOutputToSelectedDate() {
        selectedDate
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] date in
                guard let strongSelf = self else { return }
//                strongSelf.week.accept(Date.getWeekdays(of: date))
                strongSelf.fetchPlanListUseCase.execute(date: date) { plans in
                    strongSelf.sortPlansAndAccept(plans)
                }
            }).disposed(by: disposeBag)
    }
    
    private func sortPlansAndAccept(_ plans: [Plan]) {
        let sortedPlans = plans.sorted { $0.date < $1.date }
        planList.accept(sortedPlans)
    }
    
    public func getPlan(at index: Int) -> Plan {
        return planList.value[index]
    }
    
    public func getTimeLineMode(at index: Int) -> PlanListCell.TimeLineMode {
        return determineTimeLineMode(at: index)
    }
    
    private func determineTimeLineMode(at index: Int) -> PlanListCell.TimeLineMode {
        let countOfPlans = planList.value.count
        
        if countOfPlans == 1 {
            return .only
        } else {
            if index == 0 {
                return .first
            } else if index == countOfPlans - 1 {
                return .last
            } else if index != countOfPlans && countOfPlans != 1 {
                return .middle
            }
        }
        
        return .only
    }
    
    // MARK: - Input
    public func changeDate(date: Date) {
        selectedDate.accept(date)
    }
    
    public func togglePlanAchieve(at index: Int) {
        var plan = planList.value[index]
        plan.achieve = !plan.achieve
        updatePlanUseCase.execute(plan: plan) { [weak self] updatedPlan in
            guard let strongSelf = self else { return }
            strongSelf.replacePlan(of: plan.id,
                                   newPlan: updatedPlan)
        }
    }
    
    private func replacePlan(of id: Int, newPlan: Plan) {
        var updatedPlanList = planList.value
        guard let index = updatedPlanList.firstIndex(where: { $0.id == newPlan.id }) else {
            return
        }
        updatedPlanList[index] = newPlan
        planList.accept(updatedPlanList)
    }
    
    // MARK: - Action
    @objc public func presentProfile() { touchAction.onNext(.profile) }
    @objc public func presentDateSelector() { touchAction.onNext(.dateSelector) }
    @objc public func presentAddPlan() { touchAction.onNext(.addPlan) }
    @objc public func presentSearchPlan() { touchAction.onNext(.searchPlan) }
    
    
    // MARK: - Output

    public let touchAction: PublishSubject<PlanListTitleBarAction> = PublishSubject()
    public let selectedDate: BehaviorRelay<Date> = BehaviorRelay(value: Date())
//    public let week: BehaviorRelay<[Date]> = BehaviorRelay(value: [])
    public let planList: BehaviorRelay<[Plan]> = BehaviorRelay(value: [])
    public let disposeBag: DisposeBag = DisposeBag()
}
