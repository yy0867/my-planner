//
//  DefaultPlanRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class DefaultPlanRepository: PlanRepository {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func create(dto: PlanDto.Create,
                completion: (Result<PlanDto.Result, Error>) -> Void) {
        storage.create(dto: dto, completion: completion)
    }
    
    func search(dto: PlanDto.Search,
              completion: (Result<[PlanDto.Result], Error>) -> Void) {
        storage.search(dto: dto, completion: completion)
    }
    
    func update(dto: PlanDto.Update,
                completion: (Result<PlanDto.Result, Error>) -> Void) {
        storage.update(dto: dto, completion: completion)
    }
    
    func delete(id: Plan.Identifier,
                completion: (Result<Void, Error>) -> Void) {
        storage.delete(id: id, completion: completion)
    }
    
}
