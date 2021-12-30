//
//  DefaultPlanRepository.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class DefaultPlanRepository: PlanRepository {
    
    let storage: Storage
    let dtoMapper: PlanDtoMapper
    
    init(storage: Storage) {
        self.storage = storage
        self.dtoMapper = storage.dtoMapper
    }
    
    func create(dto: PlanDto.Create,
                completion: (Result<Plan, Error>) -> Void) {
        storage.create(dto: dto) { result in
            switch result {
                case .success(let dtoResult):
                    let plan = dtoMapper.asModel(dtoResult: dtoResult)
                    completion(.success(plan))
                case .failure(let e):
                    print(e.localizedDescription)
                    completion(.failure(e))
            }
        }
    }
    
    func search(dto: PlanDto.Search,
              completion: (Result<[Plan], Error>) -> Void) {
        storage.search(dto: dto) { result in
            switch result {
                case .success(let dtoResults):
                    let plans = dtoResults.map { dtoMapper.asModel(dtoResult: $0) }
                    completion(.success(plans))
                case .failure(let e):
                    print(e.localizedDescription)
                    completion(.failure(e))
            }
        }
    }
    
    func update(dto: PlanDto.Update,
                completion: (Result<Plan, Error>) -> Void) {
        storage.update(dto: dto) { result in
            switch result {
                case .success(let dtoResult):
                    let plan = dtoMapper.asModel(dtoResult: dtoResult)
                    completion(.success(plan))
                case .failure(let e):
                    print(e.localizedDescription)
                    completion(.failure(e))
            }
        }
    }
    
    func delete(id: Plan.Identifier,
                completion: (Result<Void, Error>) -> Void) {
        storage.delete(id: id, completion: completion)
    }
    
}
