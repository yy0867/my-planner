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
    func changeDate(date: Date,
                    completion: @escaping () -> Void)
}

protocol PlanListViewModelOutput {
    
    
    var selectedDate: BehaviorRelay<Date> { get }
    var week: BehaviorRelay<[Date]> { get }
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
        selectedDate.subscribe(onNext: { [weak self] date in
            guard let self = self else { return }
            self.week.accept(Date.getWeekdays(of: date))
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Input
    public func changeDate(date: Date,
                           completion: @escaping () -> Void) {
        selectedDate.accept(date)
        fetchPlanListUseCase.execute(date: date) { plans in
            self.planList.accept(plans)
            completion()
        }
    }
    
    // MARK: - Output
    public let selectedDate: BehaviorRelay<Date> = BehaviorRelay(value: Date())
    public let week: BehaviorRelay<[Date]> = BehaviorRelay(value: [])
    public let planList: BehaviorRelay<[Plan]> = BehaviorRelay(value: [])
    public let disposeBag: DisposeBag = DisposeBag()
}
