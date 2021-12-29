//
//  FetchPlanListRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/29.
//

import Foundation

protocol FetchPlanListRepository {
    
    func fetchPlanList(by query: (Plan) -> Bool,
                       completion: (Result<[Plan], Error>) -> Void)
}
