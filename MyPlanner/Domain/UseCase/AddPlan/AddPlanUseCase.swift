//
//  AddPlanUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//

import Foundation

protocol AddPlanUseCase {
    
    func execute(newPlan: Plan,
                 completion: (Plan) -> Void)
}
