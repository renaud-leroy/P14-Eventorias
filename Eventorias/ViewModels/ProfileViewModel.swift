//
//  ProfileViewModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 08/01/2026.
//

import Foundation
import FirebaseAuth
import UserNotifications
import SwiftUI

@MainActor
@Observable
final class ProfileViewModel {
    var name: String = ""
    var email: String = ""
    var isNotificationOn: Bool = false

    func loadUser() {
        guard let user = Auth.auth().currentUser else {
            return
        }

        email = user.email ?? ""

        if let displayName = user.displayName, !displayName.isEmpty {
            name = displayName
        } else if let mail = user.email,
                  let prefix = mail.split(separator: "@").first {
            name = String(prefix)
        } else {
            name = "John Doe"
        }
    }
    
    func enableNotifications() {
            NotificationService.shared.requestAuthorization()
    }
}
