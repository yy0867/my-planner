//
//  AddPlanViewModel.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/07.
//

import Foundation
import RxSwift
import RxRelay
import SwiftUI

protocol AddPlanViewModelInput {
    
    var inputTitle: BehaviorRelay<String> { get }
    var inputColor: BehaviorRelay<String> { get }
    var inputDate: BehaviorRelay<Date> { get }
    var inputTime: PublishRelay<Date> { get }
    var inputNotification: BehaviorRelay<Bool> { get }
    
    func changeDate(_ date: Date)
    func toggleNotification()
}

@objc
protocol AddPlanViewModelAction {
    func addPlan()
    func presentColorSelector()
}

protocol AddPlanViewModelOutput {
    
    var addPlanAction: BehaviorRelay<AddPlanAction> { get }
    
    func getSelectedDate() -> BehaviorRelay<Date>
}

protocol AddPlanViewModel: AddPlanViewModelInput,
                           AddPlanViewModelAction,
                           AddPlanViewModelOutput { }

class DefaultAddPlanViewModel: AddPlanViewModel {
    
    // MARK: - Properties
    private let addPlanUseCase: AddPlanUseCase
    private let planListViewModel: PlanListViewModel
    
    let inputTitle: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    let inputColor: BehaviorRelay<String> = BehaviorRelay<String>(value: Color.accentColor.toHexStr())
    let inputDate: BehaviorRelay<Date> = BehaviorRelay<Date>(value: .now)
    let inputTime: PublishRelay<Date> = PublishRelay<Date>()
    let inputNotification: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    let addPlanAction: BehaviorRelay<AddPlanAction> = BehaviorRelay<AddPlanAction>(value: .none)
    
    // MARK: - Methods
    init(addPlanUseCase: AddPlanUseCase,
         planListViewModel: PlanListViewModel) {
        self.addPlanUseCase = addPlanUseCase
        self.planListViewModel = planListViewModel
    }
    
    @objc
    func addPlan() {
        
        addPlanUseCase.execute(newPlan: createPlan()) { _ in }
    }
    
    @objc
    func presentColorSelector() {
        
        addPlanAction.accept(.colorSelector)
    }
    
    private func createPlan() -> Plan {
        
        return .init(name: inputTitle.value,
                     date: inputDate.value,
                     color: inputColor.value,
                     notification: inputNotification.value,
                     achieve: false)
    }
    
    // MARK: - Input
    public func changeDate(_ date: Date) {
        planListViewModel.changeDate(date: date)
    }
    
    public func toggleNotification() {
        let toggledValue = !inputNotification.value
        inputNotification.accept(toggledValue)
    }
    
    // MARK: - Output
    public func getSelectedDate() -> BehaviorRelay<Date> {
        return planListViewModel.selectedDate
    }
}
