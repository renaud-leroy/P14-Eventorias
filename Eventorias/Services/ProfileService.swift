//
//  ProfileService.swift
//  Eventorias
//
//  Created by Renaud Leroy on 08/01/2026.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import UIKit

protocol ProfileServiceProtocol {
    func fetchCurrentUser() async -> ProfileUser?
    func uploadProfileImage(_ image: UIImage) async -> URL?
    func updateProfile(username: String, photoURL: URL?)
    func fetchProfileImage(from url: URL) async -> UIImage?
}

final class ProfileService: ProfileServiceProtocol {

    func fetchCurrentUser() async -> ProfileUser? {
        guard let user = Auth.auth().currentUser else { return nil }

        let email = user.email ?? ""
        let displayName = user.displayName ?? ""
        let photoURL = user.photoURL

        return ProfileUser(email: email, displayName: displayName, photoURL: photoURL)
    }

    func fetchProfileImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Avatar loading error")
            return nil
        }
    }

    func uploadProfileImage(_ image: UIImage) async -> URL? {
        guard let uid = Auth.auth().currentUser?.uid,
              let data = image.jpegData(compressionQuality: 0.7)
        else {
            return nil
        }

        let ref = Storage.storage()
            .reference()
            .child("profile_images/\(uid).jpg")

        do {
            _ = try await ref.putDataAsync(data)
            let url = try await ref.downloadURL()
            return url
        } catch {
            print("Upload profile image error:")
            return nil
        }
    }

    func updateProfile(username: String, photoURL: URL?) {
        guard let user = Auth.auth().currentUser else { return }

        let request = user.createProfileChangeRequest()
        request.displayName = username
        request.photoURL = photoURL

        request.commitChanges { error in
            if let error = error {
                print(error)
            }
        }
    }
}
