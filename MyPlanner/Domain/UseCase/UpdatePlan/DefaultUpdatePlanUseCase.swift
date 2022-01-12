//
//  DefaultUpdatePlanUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/07.
//

import Foundation

final class DefaultUpdatePlanUseCase: UpdatePlanUseCase {
    
    // MARK: - Property
    let repository: PlanRepository
    
    init(repository: PlanRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    func execute(plan: Plan,
                 completion: (Plan) -> Void) {
        let updateDto = PlanDto.Update(id: plan.id,
                                       name: plan.name,
                                       date: plan.date,
                                       color: plan.color,
                                       notificationId: plan.notificationId,
                                       notification: plan.notification,
                                       achieve: plan.achieve)
        
        repository.update(dto: updateDto) { result in
            switch result {
                case .success(let plan):
                    completion(plan)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
