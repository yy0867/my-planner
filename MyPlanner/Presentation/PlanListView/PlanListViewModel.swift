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
}

protocol PlanListViewModelOutput {
    
    typealias Day = (day: Int, dayOfWeek: String)
    
    var selectedDate: BehaviorRelay<Date> { get }
    var week: BehaviorRelay<[Day]> { get }
    var planList: BehaviorRelay<[Plan]> { get }
}

protocol PlanListViewModel: PlanListViewModelInput, PlanListViewModelOutput { }

final class DefaultPlanListViewModel: PlanListViewModel {
    
    // MARK: - Properties
    private let fetchPlanListUseCase: FetchPlanListByDateUseCase
    
    init(fetchPlanListUseCase: FetchPlanListByDateUseCase) {
        self.fetchPlanListUseCase = fetchPlanListUseCase
    }
    
    private var _selectedDate: Date
    private var _week: [Day]
    private var _planList: [Plan]
    
    // MARK: - Input
    public func changeDate(date: Date) {
        self._selectedDate = date
    }
    
    // MARK: - Output aksfdgnklreiosfdj
    let selectedDate: BehaviorRelay<Date>
    let week: BehaviorRelay<[Day]>
    let planList: BehaviorRelay<[Plan]>
}
