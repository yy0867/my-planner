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
        var notificationId: NotificationId
        
        // Optional
        let id: Plan.Identifier
        let notification: Bool
        let achieve: Bool
        
        init(id: Plan.Identifier = 0,
             name: String,
             date: Date,
             color: Plan.Color,
             notificationId: NotificationId = "",
             notification: Bool = false,
             achieve: Bool = false) {
            self.id = id
            self.name = name
            self.date = date
            self.color = color
            self.notificationId = notificationId
            self.notification = notification
            self.achieve = achieve
        }
    }
    
    struct Search {
        
        // Optional
        let id: Plan.Identifier?
        let name: String?
        let date: Date?
         let color: Plan.Color?
        // let notification: Bool
        // let achieve: Bool
    }
    
    // MARK: - PlanDto.Update
    struct Update {
        
        // Require
        let id: Plan.Identifier
        let name: String
        let date: Date
        let color: Plan.Color
        var notificationId: NotificationId
        let notification: Bool
        let achieve: Bool
    }
    
    // MARK: - PlanDto.Delete
    struct Delete {
        
        // Require
        let id: Plan.Identifier
        let notificationId: NotificationId
    }
    
    // MARK: - PlanDto.Result
    struct Result {
        
        let id: Plan.Identifier
        let name: String
        let date: Date
        let color: Plan.Color
        let notificationId: NotificationId
        let notification: Bool
        let achieve: Bool
    }
}
