//
//  RealmSavePlanStorage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class RealmSavePlanStorage: SavePlanStorage {
    
    func savePlan(_ plan: PlanEntity,
                  completion: (Result<Plan, Error>) -> Void) {
        
        do {
            let realm = try RealmStorage.shared.realm()
            plan.incrementId()
            try realm.write {
                realm.add(plan)
                completion(.success(plan.asDomain()))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
