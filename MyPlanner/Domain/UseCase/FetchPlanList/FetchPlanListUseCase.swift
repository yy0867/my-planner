//
//  FetchPlanListUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//

import Foundation

protocol FetchPlanListUseCase {
    
    func execute(id: Plan.Identifier?,
                 name: String?,
                 date: Date?,
                 color: Plan.Color?,
                 completion: ([Plan]) -> Void)
}

extension FetchPlanListUseCase {
    
    func execute(id: Plan.Identifier? = nil,
                 name: String? = nil,
                 date: Date? = nil,
                 color: Plan.Color? = nil,
                 completion: ([Plan]) -> Void) {
        execute(id: id, name: name, date: date, color: color, completion: completion)
    }
}
