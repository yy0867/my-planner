//
//  DefaultSavePlanRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

final class DefaultSavePlanRepository: SavePlanRepository {
    
    let savePlanStorage: SavePlanStorage
    
    init(savePlanStorage: SavePlanStorage) {
        self.savePlanStorage = savePlanStorage
    }
    
    func savePlan(_ plan: Plan,
                  completion: (Result<Plan, Error>) -> Void) {
        let planEntity = plan.asRealmObject()
        savePlanStorage.savePlan(planEntity, completion: completion)
    }
}
