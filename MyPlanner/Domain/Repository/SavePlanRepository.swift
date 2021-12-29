//
//  SavePlanRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol SavePlanRepository {
    
    func savePlan(_ plan: Plan, completion: (Result<Plan, Error>) -> Void)
}
