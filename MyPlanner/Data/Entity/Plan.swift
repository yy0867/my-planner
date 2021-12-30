//
//  Plan.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/29.
//

import Foundation

struct Plan {
    
    typealias Identifier = Int
    typealias Color = String
    
    var id: Identifier = 0
    var name: String
    var date: Date
    var color: Color
    var notification: Bool
    var achieve: Bool
}
