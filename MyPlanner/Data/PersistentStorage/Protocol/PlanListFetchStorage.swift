//
//  PlanListResponseStorage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol PlanListFetchStorage {
    
    func fetchPlanList(by query: (PlanEntity) -> Bool,
                       completion: (Result<[Plan], Error>) -> Void)
}
