//
//  PlanDtoMapper.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

class PlanDtoMapper: DtoMapper {
    
    func asEntity(dtoCreate: PlanDto.Create) -> Plan {
        return .init(name: dtoCreate.name,
                     date: dtoCreate.date,
                     color: dtoCreate.color,
                     notification: dtoCreate.notification ?? false,
                     achieve: dtoCreate.achieve ?? false)
    }
    
    func asResultDto(entity: Plan) -> PlanDto.Result {
        return .init(id: entity.id,
                     name: entity.name,
                     date: entity.date,
                     color: entity.color,
                     notification: entity.notification,
                     achieve: entity.achieve)
    }
}
