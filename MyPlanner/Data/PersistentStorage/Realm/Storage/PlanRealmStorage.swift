//
//  PlanRealmStorage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class PlanRealmStorage: Storage {
    
    let dtoMapper: PlanDtoMapper
    
    init(dtoMapper: PlanDtoMapper) {
        self.dtoMapper = dtoMapper
    }
    
    func create(dto: PlanDto.Create,
                completion: (Result<PlanDto.Result, Error>) -> Void) {
        
        do {
            let realm = try RealmStorage.shared.realm()
            
            let plan = RealmPlan(dto: dto, mapper: dtoMapper)
            plan.incrementId()
            
            try realm.write {
                realm.add(plan)
                completion(.success(plan.asResultDto()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func search(dto: PlanDto.Search,
              completion: (Result<[PlanDto.Result], Error>) -> Void) {
        
        do {
            let realm = try RealmStorage.shared.realm()
            let result = realm
                .objects(RealmPlan.self)
                .filter(makeQuery(dto: dto))
                .map { $0.asResultDto() }
            
            completion(.success(Array(result)))
        } catch {
            completion(.failure(error))
        }
    }
    
    func update(dto: PlanDto.Update,
                completion: (Result<PlanDto.Result, Error>) -> Void) {
        
        do {
            let realm = try RealmStorage.shared.realm()
            let updateEntity = makeUpdateEntity(dto: dto)
            
            try realm.write {
                realm.add(updateEntity, update: .modified)
                completion(.success(updateEntity.asResultDto()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(id: Plan.Identifier,
                completion: (Result<Void, Error>) -> Void) {
        
        do {
            let realm = try RealmStorage.shared.realm()
            
            try realm.write {
                let plan = realm
                    .objects(RealmPlan.self)
                    .filter { $0.id == id }
                
                realm.delete(plan)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

extension PlanRealmStorage {
    
    // MARK: - Search
    typealias Query = (RealmPlan) -> Bool
    
    func makeQuery(dto: PlanDto.Search) -> Query {
        return { plan in
            
            if let id = dto.id {
                if plan.id != id { return false }
            }
            
            if let name = dto.name {
                if plan.name != name { return false }
            }
            
            if let date = dto.date {
                // YYYY-MM-dd 형식으로 비교
                if !Calendar(identifier: .gregorian).isDate(date, inSameDayAs: plan.date) {
                    return false
                }
            }
            
            return true
        }
    }
    
    // MARK: - Update
    func makeUpdateEntity(dto: PlanDto.Update) -> RealmPlan {
        let plan = RealmPlan()
        
        plan.id = dto.id
        plan.name = dto.name
        plan.date = dto.date
        plan.color = dto.color
        plan.notification = dto.notification
        plan.notificationId = dto.notificationId
        plan.achieve = dto.achieve
        
        return plan
    }
}
