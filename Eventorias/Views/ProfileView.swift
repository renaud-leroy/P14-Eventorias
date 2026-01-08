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
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .ignoresSafeArea()
            VStack(spacing: 26) {
                FormField(label: "Name", placeholder: ProfileVM.name, isSecureTextEntry: false, text: $ProfileVM.name)
                FormField(label: "Email", placeholder: ProfileVM.email, isSecureTextEntry: false, text: $ProfileVM.email)
                HStack(spacing: 20) {
                    Toggle("", isOn: $ProfileVM.isNotificationOn)
                        .tint(Color(.customRed))
                        .labelsHidden()
                        .onChange(of: ProfileVM.isNotificationOn) { _, newValue in
                            if newValue {
                                ProfileVM.enableNotifications()                            }
                        }
                    Text("Notifications")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    Spacer()
                }
                Spacer()
                    .padding(.vertical)
            }
            .padding()
            .onAppear() {
                ProfileVM.loadUser()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Text("User profile")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    ProfileView(ProfileVM: ProfileViewModel())
}
