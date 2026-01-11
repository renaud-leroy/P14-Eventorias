//
//  ProfileView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI
import UserNotifications
import PhotosUI

struct ProfileView: View {
    @Bindable var profileVM: ProfileViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing: 26) {
            FormField(label: "Name", placeholder: profileVM.name, isSecureTextEntry: false, text: $profileVM.name)
            FormField(label: "Email", placeholder: profileVM.email, isSecureTextEntry: false, text: $profileVM.email)
            HStack(spacing: 20) {
                Toggle("", isOn: $profileVM.isNotificationOn)
                    .tint(Color(.customRed))
                    .labelsHidden()
                    .onChange(of: profileVM.isNotificationOn) { _, newValue in
                        if newValue {
                            profileVM.enableNotifications()
                        }
                    }
                Text("Notifications")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                Spacer()
            }
            Spacer()
                .padding(.vertical)
                .background(Color(.customColorBackground))
        }
        .padding()
        .task {
            await profileVM.loadUserIfNeeded()
        }
        .navigationTitle(Text("User profile"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    profileVM.showPhotoPicker.toggle()
                } label: {
                    Group {
                        if let image = profileVM.profileImage {
                            Image(uiImage: image)
                                .resizable()
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                        }
                    }
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                }
            }
        }
        .photosPicker(
            isPresented: $profileVM.showPhotoPicker,
            selection: $selectedPhoto,
            matching: .images
        )
        .onChange(of: selectedPhoto) { _, newItem in
            guard let newItem else { return }

            Task {
                do {
                    if let data = try await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        await profileVM.updateProfileImage(image)
                    }
                } catch {
                    profileVM.errorMessage = "Failed to load selected photo"
                }
            }
        }
        .errorAlert(message: $profileVM.errorMessage)
    }
}

#Preview {
    ProfileView(profileVM: ProfileViewModel(profileService: ProfileService()))
}

