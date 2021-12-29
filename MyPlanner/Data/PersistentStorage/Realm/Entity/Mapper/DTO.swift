//
//  DTO.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import RealmSwift

protocol DTO {
    
    associatedtype E: Object
    
    func asRealmObject() -> E
}
