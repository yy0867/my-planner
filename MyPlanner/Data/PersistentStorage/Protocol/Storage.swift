//
//  Storage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol Storage {
    
    func create(dto: PlanDto.Create,
                completion: (Result<PlanDto.Result, Error>) -> Void)
    
    func search(dto: PlanDto.Search,
              completion: (Result<[PlanDto.Result], Error>) -> Void)
    
    func update(dto: PlanDto.Update,
                completion: (Result<PlanDto.Result, Error>) -> Void)
    
    func delete(id: Plan.Identifier,
                completion: (Result<Void, Error>) -> Void)
}
