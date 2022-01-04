//
//  FetchPlanListUseCase.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//

import Foundation

protocol FetchPlanListByDateUseCase {
    
    func execute(date: Date,
                 completion: ([Plan]) -> Void)
}
