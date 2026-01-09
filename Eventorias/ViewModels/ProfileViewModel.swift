//
//  ProfileViewModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 08/01/2026.
//

import Foundation
import UserNotifications
import SwiftUI

@MainActor
@Observable
final class ProfileViewModel {

    var name = ""
    var email = ""
    var profileImage: UIImage?
    var isNotificationOn: Bool = false
    var showPhotoPicker: Bool = false

    private let profileService: ProfileServiceProtocol

    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
    }

    func loadUser() async {
        guard let user = await profileService.fetchCurrentUser() else { return }

        email = user.email
        name = user.displayName

        if let imageURL = user.photoURL {
            profileImage = await profileService.fetchProfileImage(from: imageURL)
        }
    }

    func updateProfileImage(_ image: UIImage) async {
        guard let url = await profileService.uploadProfileImage(image) else { return }
        profileService.updateProfile(username: name, photoURL: url)
        profileImage = image
    }

    func enableNotifications() {
        NotificationService.shared.requestAuthorization()
    }
}
