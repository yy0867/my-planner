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
                     notificationId: dtoCreate.notificationId,
                     notification: dtoCreate.notification,
                     achieve: dtoCreate.achieve)
    }
    
    func asModel(dtoResult: PlanDto.Result) -> Plan {
        return .init(id: dtoResult.id,
                     name: dtoResult.name,
                     date: dtoResult.date,
                     color: dtoResult.color,
                     notificationId: dtoResult.notificationId,
                     notification: dtoResult.notification,
                     achieve: dtoResult.achieve)
    }
    
    func asResultDto(entity: Plan) -> PlanDto.Result {
        return .init(id: entity.id,
                     name: entity.name,
                     date: entity.date,
                     color: entity.color,
                     notificationId: entity.notificationId,
                     notification: entity.notification,
                     achieve: entity.achieve)
    }
}
