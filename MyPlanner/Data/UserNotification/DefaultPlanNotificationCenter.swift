//
//  DefaultNotificationCenter.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/11.
//

import Foundation
import UserNotifications

class DefaultPlanNotificationCenter: PlanNotificationCenter {
    
    // MARK: - Properties
    
    // MARK: - Methods
    func createNotification(of dto: inout PlanDto.Create) {
        
        if dto.notification == true {
            let notificationId = requestPendingNotification(name: dto.name, date: dto.date)
            dto.notificationId = notificationId
            print("\(dto.name) add notification.")
        }
    }
    
    func updateNotification(of dto: inout PlanDto.Update) {
        
        if dto.notification == true {
            if !dto.notificationId.isEmpty {
                removePendingNotification(of: dto.notificationId)
            }
            let notificationId = requestPendingNotification(name: dto.name, date: dto.date)
            dto.notificationId = notificationId
            
        } else if dto.notification == false && !dto.notificationId.isEmpty {
            removePendingNotification(of: dto.notificationId)
            dto.notificationId = ""
            print("\(dto.name) delete notification.")
        }
    }
    
    func deleteNotification(of notificationId: NotificationId) {
        print("delete notification. -> ")
        if !notificationId.isEmpty {
            print("\(notificationId) delete notification.")
        }
    }
    
    private func requestPendingNotification(name: String, date: Date) -> NotificationId {
        if date < .now { return "" }
        
        let content = UNMutableNotificationContent()
        content.title = name
        content.body = date.toString(format: "M/d (EEE) HH:mm")
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date.toNotificationDateComponent(),
                                                    repeats: false)
        
        let notificationId = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationId,
                                            content: content,
                                            trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error")
                print(error.localizedDescription)
            }
        }
        
        return notificationId
    }
    
    private func removePendingNotification(of notificationId: NotificationId) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
    }
}
