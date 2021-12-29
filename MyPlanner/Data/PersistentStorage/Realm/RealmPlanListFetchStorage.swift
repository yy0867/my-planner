//
//  RealmPlanListResponseStorage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class RealmPlanListFetchStorage: PlanListFetchStorage {
    
    func fetchPlanList(by query: (PlanEntity) -> Bool,
                       completion: (Result<[Plan], Error>) -> Void) {
        
        do {
            let realm = try RealmStorage.shared.realm()
            let fetchResult = realm.objects(PlanEntity.self)
                .filter(query)
                .map { $0.asDomain() }
            
            completion(.success(Array(fetchResult)))
        } catch {
            completion(.failure(error))
        }
    }
}
