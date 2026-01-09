//
//  NotificationService.swift
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
            let reminderDate = Calendar.current.date(
                byAdding: .minute,
                value: -10,
                to: date
            )

            guard let reminderDate,
                  reminderDate > Date() else {
                print("Date passée")
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Rappel d'événement"
            content.body = "\(title) commence dans 10 minutes"
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
