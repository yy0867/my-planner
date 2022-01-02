//
//  Plan+Stub.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
@testable import MyPlanner

extension Plan {
    
    static func stub(id: Plan.Identifier = 0,
                     name: String = "PlanName",
                     date: Date,
                     color: Plan.Color = "#FFFFFF",
                     notification: Bool = false,
                     achieve: Bool = false) -> Self {
        return .init(id: id,
                     name: name,
                     date: date,
                     color: color,
                     notification: notification,
                     achieve: achieve)
    }
}
