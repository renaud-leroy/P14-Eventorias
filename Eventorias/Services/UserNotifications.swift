//
//  UserNotifications.swift
//  Eventorias
//
//  Created by Renaud Leroy on 07/01/2026.
//

import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard error == nil else { return }
        }
    }
    
    func eventReminder(title: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Rappel"
        content.body = title

        guard let triggerDate = Calendar.current.date(byAdding: .minute, value: -10, to: date) else {
            return
        }

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: triggerDate
            ),
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
