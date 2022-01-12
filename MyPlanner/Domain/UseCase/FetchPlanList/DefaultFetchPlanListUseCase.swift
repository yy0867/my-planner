//
//  FetchPlanListUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class DefaultFetchPlanListUseCase: FetchPlanListUseCase {
    
    // MARK: - Property
    let repository: PlanRepository
    
    init(repository: PlanRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    func execute(id: Plan.Identifier? = nil,
                 name: String? = nil,
                 date: Date? = nil,
                 color: Plan.Color? = nil,
                 completion: ([Plan]) -> Void) {
        let searchDto = PlanDto.Search(id: id,
                                       name: name,
                                       date: date,
                                       color: color)
        
        repository.search(dto: searchDto) { result in
            switch result {
                case .success(let r):
                    print("\(self.self)::\(r)")
                    completion(r)
                case .failure(let e):
                    print(e.localizedDescription)
                    completion([])
            }
        }
    }
}
