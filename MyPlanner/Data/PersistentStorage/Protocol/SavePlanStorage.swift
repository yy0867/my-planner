//
//  SavePlanStorage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol SavePlanStorage {
    
    func savePlan(_ plan: PlanEntity,
                  completion: (Result<Plan, Error>) -> Void)
}
