//
//  DTO.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

struct PlanDto {
    
    // MARK: - PlanDto.Create
    struct Create {
        
        // Require
        let name: String
        let date: Date
        let color: Plan.Color
        
        // Optional
        let id: Plan.Identifier? = 0
        let notification: Bool? = false
        let achieve: Bool? = false
    }
    
    struct Search {
        
        // Optional
        let id: Plan.Identifier?
        let name: String?
        let date: Date?
        // let color: Plan.Color
        // let notification: Bool
        // let achieve: Bool
    }
    
    // MARK: - PlanDto.Update
    struct Update {
        
        // Require
        let id: Plan.Identifier
        
        // Optional
        let name: String?
        let date: Date?
        let color: Plan.Color?
        let notification: Bool?
        let achieve: Bool?
    }
    
    // MARK: - PlanDto.Result
    struct Result {
        
        let id: Plan.Identifier
        let name: String
        let date: Date
        let color: Plan.Color
        let notification: Bool
        let achieve: Bool
    }
}
