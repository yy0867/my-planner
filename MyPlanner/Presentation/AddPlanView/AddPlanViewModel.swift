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
    var inputColor: BehaviorRelay<Plan.Color> { get }
    var inputDate: BehaviorRelay<Date> { get }
    var inputTime: BehaviorRelay<Date> { get }
    var inputNotification: BehaviorRelay<Bool> { get }
    
    func changeDate(_ date: Date)
    func toggleNotification()
    func changeColor(_ color: Plan.Color)
}

@objc
protocol AddPlanViewModelAction {
    func addPlan()
    func presentColorSelector()
}

protocol AddPlanViewModelOutput {
    
    var addPlanAction: BehaviorRelay<ColorSelectableAction> { get }
    
    func allFieldValid() -> Observable<Bool>
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
    let inputColor: BehaviorRelay<Plan.Color> = BehaviorRelay<Plan.Color>(value: Color.accentColor.toHexStr())
    let inputDate: BehaviorRelay<Date>
    let inputTime: BehaviorRelay<Date> = BehaviorRelay<Date>(value: .createTime(hour: 10, minute: 00))
    let inputNotification: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    let addPlanAction: BehaviorRelay<ColorSelectableAction> = BehaviorRelay<ColorSelectableAction>(value: .none)
    
    // MARK: - Methods
    init(addPlanUseCase: AddPlanUseCase,
         planListViewModel: PlanListViewModel) {
        self.addPlanUseCase = addPlanUseCase
        self.planListViewModel = planListViewModel
        
        inputDate = BehaviorRelay<Date>(value: planListViewModel.selectedDate.value)
    }
    
    @objc
    func addPlan() {
        addPlanUseCase.execute(newPlan: createPlan()) { [weak self] _ in
            self?.changeDate(inputDate.value)
        }
    }
    
    @objc
    func presentColorSelector() {
        
        addPlanAction.accept(.colorSelector)
    }
    
    private func createPlan() -> Plan {
        let inputDate = inputDate.value
        let inputTime = inputTime.value
        
        let date = Date.createDate(year: inputDate.getComponent(of: .year),
                                   month: inputDate.getComponent(of: .month),
                                   day: inputDate.getComponent(of: .day),
                                   hour: inputTime.getComponent(of: .hour),
                                   minute: inputTime.getComponent(of: .minute))
        
        return .init(name: inputTitle.value,
                     date: date,
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
    
    public func changeColor(_ color: Plan.Color) {
        inputColor.accept(color)
    }
    
    // MARK: - Output
    public func getSelectedDate() -> BehaviorRelay<Date> {
        return planListViewModel.selectedDate
    }
    
    public func allFieldValid() -> Observable<Bool> {
        return Observable.combineLatest(inputTitle, inputTime).map { title, _ in
            return !title.isEmpty
        }
    }
}
