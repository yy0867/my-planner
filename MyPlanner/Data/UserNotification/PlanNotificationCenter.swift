//
//  NotificationCenter.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/11.
//

import Foundation

typealias NotificationId = String

protocol PlanNotificationCenter {
    
    func createNotification(of dto: inout PlanDto.Create)
    func updateNotification(of dto: inout PlanDto.Update)
    func deleteNotification(of notificationId: NotificationId)
}
