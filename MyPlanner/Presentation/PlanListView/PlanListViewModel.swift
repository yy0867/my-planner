//
//  PlanListViewModel.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/31.
//

import Foundation
import RxSwift
import RxRelay

@objc
protocol PlanListViewModelInput {
    
    func changeDate(date: Date)
    func presentProfile()
    func presentDateSelector()
    func presentAddPlan()
    func presentSearchPlan()
}

protocol PlanListViewModelOutput {
    
    var touchAction: PublishSubject<PlanListTitleBarAction> { get }
    var selectedDate: BehaviorRelay<Date> { get }
//    var week: BehaviorRelay<[Date]> { get }
    var planList: BehaviorRelay<[Plan]> { get }
    var disposeBag: DisposeBag { get }
}

protocol PlanListViewModel: PlanListViewModelInput, PlanListViewModelOutput { }

final class DefaultPlanListViewModel: PlanListViewModel {
    
    // MARK: - Properties
    private let fetchPlanListUseCase: FetchPlanListByDateUseCase
    
    init(fetchPlanListUseCase: FetchPlanListByDateUseCase) {
        self.fetchPlanListUseCase = fetchPlanListUseCase
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
                    strongSelf.planList.accept(plans)
                }
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Input
    public func changeDate(date: Date) {
        selectedDate.accept(date)
    }
    
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
