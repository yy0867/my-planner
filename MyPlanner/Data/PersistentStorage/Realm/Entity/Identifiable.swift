//
//  Identifiable.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation

protocol Identifiable {
    
    var id: Int { get set }
    
    func incrementId()
}
