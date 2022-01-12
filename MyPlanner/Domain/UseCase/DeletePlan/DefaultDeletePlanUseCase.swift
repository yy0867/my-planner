//
//  DefaultUpdatePlanUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/07.
//

import Foundation

final class DefaultDeletePlanUseCase: DeletePlanUseCase {
    
    // MARK: - Property
    let repository: PlanRepository
    
    init(repository: PlanRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    func execute(plan: Plan,
                 completion: () -> Void) {
        
        let deleteDto = PlanDto.Delete(id: plan.id,
                                       notificationId: plan.notificationId)
        
        repository.delete(dto: deleteDto) { result in
            switch result {
                case .success(_):
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
