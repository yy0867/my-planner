//
//  PlanMapper.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import RealmSwift

extension Plan: DTO {
    
    func asRealmObject() -> PlanEntity {
        return PlanEntity.init(name: name,
                               date: date,
                               color: color,
                               notification: notification,
                               achieve: achieve)
    }
}

extension PlanEntity {
    
    func asDomain() -> Plan {
        return .init(id: id,
                     name: name,
                     date: date,
                     color: color,
                     notification: notification,
                     achieve: achieve)
    }
}
