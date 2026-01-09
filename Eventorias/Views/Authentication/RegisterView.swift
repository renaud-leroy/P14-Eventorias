//
//  RegisterView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 02/01/2026.
//

import SwiftUI

struct RegisterView: View {
    let vm: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Register")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.customWhite)
                    .padding(30)
                FormField(label: "Email", placeholder: "", isSecureTextEntry: false, text: $email)
                FormField(label: "Password", placeholder: "", isSecureTextEntry: true, text: $password)
                FormField(label: "Confirmation", placeholder: "", isSecureTextEntry: true, text: $confirmPassword)
                Button {
                   Task {
                        await vm.register(email: email, password: password)
                    }
                } label: {
                    CustomButton(label: "Sign Up", iconName: "person.badge.plus")
                        .padding(20)
                }
                HStack {
                    Text("Have an account")
                        .foregroundStyle(.customColorTextForm)
                        .font(.caption)
                    Button {
                        dismiss()
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(.customRed)
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView(vm: AuthViewModel(isAuthenticated: false, authService: AuthService()))
}
