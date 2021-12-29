//
//  RealmStorage.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import RealmSwift

class RealmStorage {
    
    static let shared = RealmStorage()
    
    func realm() throws -> Realm {
        return try Realm()
    }
}
