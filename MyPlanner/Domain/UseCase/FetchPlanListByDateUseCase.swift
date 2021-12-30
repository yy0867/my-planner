//
//  FetchPlanListUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class FetchPlanListByDateUseCase {
    
    // MARK: - Property
    let repository: PlanRepository
    
    init(repository: PlanRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    func execute(date: Date, completion: ([Plan]) -> Void) {
        let searchDto = PlanDto.Search(id: nil,
                                       name: nil,
                                       date: date)
        
        repository.search(dto: searchDto) { result in
            switch result {
                case .success(let r):
                    completion(r)
                case .failure(let e):
                    print(e.localizedDescription)
                    completion([])
            }
        }
    }
}
