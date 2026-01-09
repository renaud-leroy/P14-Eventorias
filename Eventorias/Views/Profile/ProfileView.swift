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
    @Bindable var ProfileVM: ProfileViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing: 26) {
            FormField(label: "Name", placeholder: ProfileVM.name, isSecureTextEntry: false, text: $ProfileVM.name)
            FormField(label: "Email", placeholder: ProfileVM.email, isSecureTextEntry: false, text: $ProfileVM.email)
            HStack(spacing: 20) {
                Toggle("", isOn: $ProfileVM.isNotificationOn)
                    .tint(Color(.customRed))
                    .labelsHidden()
                    .onChange(of: ProfileVM.isNotificationOn) { _, newValue in
                        if newValue {
                            ProfileVM.enableNotifications()
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
        .onAppear {
            Task {
                await ProfileVM.loadUser()
            }
        }
        .navigationTitle(Text("User profile"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    ProfileVM.showPhotoPicker.toggle()
                } label: {
                    Group {
                        if let image = ProfileVM.profileImage {
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
            isPresented: $ProfileVM.showPhotoPicker,
            selection: $selectedPhoto,
            matching: .images
        )
        .onChange(of: selectedPhoto) { _, newItem in
            guard let newItem else { return }

            Task {
                do {
                    if let data = try await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        await ProfileVM.updateProfileImage(image)
                    }
                } catch {
                    print("Erreur sélection photo")
                }
            }
        }
    }
}

#Preview {
    ProfileView(ProfileVM: ProfileViewModel(profileService: ProfileService()))
}
