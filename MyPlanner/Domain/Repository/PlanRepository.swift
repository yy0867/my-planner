//
//  PlanListRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol PlanRepository {
    
    func create(dto: PlanDto.Create,
                completion: (Result<Plan, Error>) -> Void)
    
    func search(dto: PlanDto.Search,
              completion: (Result<[Plan], Error>) -> Void)
    
    func update(dto: PlanDto.Update,
                completion: (Result<Plan, Error>) -> Void)
    
    func delete(dto: PlanDto.Delete,
                completion: (Result<Void, Error>) -> Void)
}
