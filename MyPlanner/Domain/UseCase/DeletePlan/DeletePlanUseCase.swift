//
//  UpdatePlanUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/07.
//

import Foundation

protocol DeletePlanUseCase {
    
    /// plan.id required
    func execute(plan: Plan,
                 completion: () -> Void)
}
