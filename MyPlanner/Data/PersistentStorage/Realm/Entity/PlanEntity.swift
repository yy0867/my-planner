//
//  PlanEntity.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import RealmSwift

class PlanEntity: Object, Identifiable {
    
    @Persisted(primaryKey: true)
    var id = 0
    
    @Persisted
    var name = ""
    
    @Persisted
    var date = Date()
    
    @Persisted
    var color = "#FFFFFF"
    
    @Persisted
    var notification = false
    
    @Persisted
    var achieve = false
    
    func incrementId() {
        guard let realm = try? RealmStorage.shared.realm() else { return }
        
        self.id = (realm.objects(Self.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

// MARK: - convenience init
extension PlanEntity {
    
    convenience init(name: String,
                     date: Date,
                     color: String,
                     notification: Bool,
                     achieve: Bool)
    {
        self.init()
        self.name = name
        self.date = date
        self.color = color
        self.notification = notification
        self.achieve = achieve
    }
}
