//
//  EditPlanViewModel.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/10.
//

import Foundation
import RxRelay
import RxSwift

protocol EditPlanViewModelInput {
    
    func deletePlan()
    func updatePlan()
    func changeDate(_ date: Date)
    func toggleNotification()
    func changeColor(_ color: Plan.Color)
}

protocol EditPlanViewModelAction {
    
    func presentColorSelector()
}

protocol EditPlanViewModelOutput {
    
    var colorSelectableAction: BehaviorRelay<ColorSelectableAction> { get }
    var inputTitle: BehaviorRelay<String> { get }
    var inputColor: BehaviorRelay<Plan.Color> { get }
    var inputDate: BehaviorRelay<Date> { get }
    var inputTime: BehaviorRelay<Date> { get }
    var inputNotification: BehaviorRelay<Bool> { get }
    var id: Plan.Identifier { get }
    var achieve: Bool { get }
    
    func allFieldValid() -> Observable<Bool>
    func getSelectedDate() -> Date
}

protocol EditPlanViewModel: EditPlanViewModelInput,
                            EditPlanViewModelOutput,
                            EditPlanViewModelAction { }

class DefaultEditPlanViewModel: EditPlanViewModel {
    
    // MARK: - Properties
    let planListViewModel: PlanListViewModel
    let updatePlanUseCase: UpdatePlanUseCase
    let deletePlanUseCase: DeletePlanUseCase
    let disposeBag = DisposeBag()
    
    let colorSelectableAction = BehaviorRelay<ColorSelectableAction>(value: .none)
    let inputTitle = BehaviorRelay<String>(value: "")
    let inputColor = BehaviorRelay<Plan.Color>(value: "")
    let inputDate = BehaviorRelay<Date>(value: .now)
    let inputTime = BehaviorRelay<Date>(value: .now)
    let inputNotification = BehaviorRelay<Bool>(value: false)
    var id: Plan.Identifier = 0
    var achieve: Bool = false
    
    // MARK: - Methods
    init(planListViewModel: PlanListViewModel,
         updatePlanUseCase: UpdatePlanUseCase,
         deletePlanUseCase: DeletePlanUseCase) {
        self.planListViewModel = planListViewModel
        self.updatePlanUseCase = updatePlanUseCase
        self.deletePlanUseCase = deletePlanUseCase
        initializeRelays()
        
    }
    
    private func initializeRelays() {
        planListViewModel.selectedPlan
            .subscribe(onNext: { [weak self] plan in
                guard let strongSelf = self, let plan = plan else { return }
                strongSelf.inputTitle.accept(plan.name)
                strongSelf.inputColor.accept(plan.color)
                strongSelf.inputDate.accept(plan.date)
                strongSelf.inputTime.accept(plan.date)
                strongSelf.inputNotification.accept(plan.notification)
                strongSelf.id = plan.id
                strongSelf.achieve = plan.achieve
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Input
    public func changeColor(_ color: Plan.Color) {
        inputColor.accept(color)
    }
    
    public func toggleNotification() {
        let toggledValue = !inputNotification.value
        inputNotification.accept(toggledValue)
    }
    
    public func updatePlan() {
        updatePlanUseCase.execute(plan: createPlan()) { [weak self] _ in
            self?.changeDate(inputDate.value)
        }
    }
    
    public func changeDate(_ date: Date) {
        planListViewModel.changeDate(date: date)
    }
    
    private func createPlan() -> Plan {
        let inputDate = inputDate.value
        let inputTime = inputTime.value
        
        let date = Date.createDate(year: inputDate.getComponent(of: .year),
                                   month: inputDate.getComponent(of: .month),
                                   day: inputDate.getComponent(of: .day),
                                   hour: inputTime.getComponent(of: .hour),
                                   minute: inputTime.getComponent(of: .minute))
        
        return .init(id: id,
                     name: inputTitle.value,
                     date: date,
                     color: inputColor.value,
                     notification: inputNotification.value,
                     achieve: achieve)
    }
    
    public func deletePlan() {
        guard let selectedPlan = try? planListViewModel.selectedPlan.value() else { return }
        deletePlanUseCase.execute(plan: selectedPlan, completion: { })
    }
    
    // MARK: - Action
    public func presentColorSelector() {
        colorSelectableAction.accept(.colorSelector)
    }
    
    // MARK: - Output
    public func allFieldValid() -> Observable<Bool> {
        return Observable.combineLatest(inputTitle, inputTime).map { title, _ in
            return !title.isEmpty
        }
    }
    
    public func getSelectedDate() -> Date {
        return try! planListViewModel.selectedPlan.value()!.date
    }
}
