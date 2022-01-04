//
//  AddPlanUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/31.
//

import Foundation

class DefaultAddPlanUseCase: AddPlanUseCase {
    
    // MARK: - Property
    let repository: PlanRepository
    
    init(repository: PlanRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    func execute(newPlan: Plan,
                 completion: (Plan) -> Void) {
        let createDto = PlanDto.Create(name: newPlan.name,
                                       date: newPlan.date,
                                       color: newPlan.color,
                                       notification: newPlan.notification,
                                       achieve: newPlan.achieve)
        
        repository.create(dto: createDto) { result in
            switch result {
                case .success(let plan):
                    completion(plan)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
