//
//  NotificationService.swift
//  Eventorias
//
//  Created by Renaud Leroy on 07/01/2026.
//

import Foundation
import UserNotifications

protocol NotificationServiceProtocol {
    func requestAuthorization()
    func eventReminder(title: String, date: Date)
}

final class NotificationService: NotificationServiceProtocol {
    static let shared: NotificationServiceProtocol = NotificationService()
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { _, _ in }
    }
    
    func eventReminder(title: String, date: Date) {
            let reminderDate = Calendar.current.date(
                byAdding: .minute,
                value: -10,
                to: date
            )

            guard let reminderDate,
                  reminderDate > Date() else {
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Event reminder"
            content.body = "\(title) starts in 10 minutes"
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: reminderDate.timeIntervalSinceNow,
                repeats: false
            )
            let identifier = UUID().uuidString
            let request = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: trigger
            )
            UNUserNotificationCenter.current().add(request)
        }
}
