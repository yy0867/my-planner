//
//  DtoMapper.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol DtoMapper {
    
    associatedtype DTO_CREATE
    associatedtype DTO_RESULT
    associatedtype E
    
    func asEntity(dtoCreate: DTO_CREATE) -> E
    func asResultDto(entity: E) -> DTO_RESULT
}
