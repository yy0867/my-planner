//
//  DefaultFetchPlanListRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

final class DefaultFetchPlanListRepository: FetchPlanListRepository {
    
    let planListFetchStorage: PlanListFetchStorage
    
    init(planListFetchStorage: PlanListFetchStorage) {
        self.planListFetchStorage = planListFetchStorage
    }
    
    func fetchPlanList(by query: (Plan) -> Bool,
                       completion: (Result<[Plan], Error>) -> Void) {
        
        let planListQuery: (PlanEntity) -> Bool = { planEntity in
            let plan = planEntity.asDomain()
            return query(plan)
        }
        
        planListFetchStorage.fetchPlanList(by: planListQuery, completion: completion)
    }
}
