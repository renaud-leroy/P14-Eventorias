//
//  ProfileView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var text: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var isNotificationOn: Bool = true
    
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .ignoresSafeArea()
            VStack(spacing: 26) {
                FormField(label: "Name", placeholder: "Christopher Evan", isSecureTextEntry: false, text: $name)
                FormField(label: "Email", placeholder: "christopherevans@gmail.com", isSecureTextEntry: false, text: $email)
                HStack(spacing: 20) {
                    Toggle("", isOn: $isNotificationOn)
                        .tint(Color(.customRed))
                        .labelsHidden()
                    Text("Notifications")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    Spacer()
                }
                Spacer()
                    .padding(.vertical)
            }
            .padding()
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
    ProfileView()
}
