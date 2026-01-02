//
//  AuthView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct AuthView: View {
    @State var vm: AuthViewModel
    @State private var showForm: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image("logoEventorias")
                        .padding(.top, 130)
                        .padding(.bottom, 50)
                    FormField(label: "Email",
                              placeholder: "",
                              isSecureTextEntry: false,
                              text: $email)
                        .frame(maxWidth: 300)
                    FormField(label: "Password",
                              placeholder: "",
                              isSecureTextEntry: true,
                              text: $password)
                        .frame(maxWidth: 300)
                    Button {
                        Task {
                            try await vm.login(email: email, password: password)
                        }
                    } label: {
                        CustomButton(label: "Sign in with Mail", iconName: "envelope.fill")
                            .padding(30)
                    }
                    Divider()
                        .background(Color(.customColorTextForm))
                        .frame(maxWidth: 300)
                        .padding(.bottom, 30)
                    Text("No account? Sign up")
                        .foregroundStyle(.customColorTextForm)
                        .font(.caption)
                    Button {
                        // vue signUp à implementer
                    } label: {
                        CustomButton(label: "Sign Up", iconName: "person.badge.plus")
                            .padding(10)
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.customColorBackground))
            .navigationDestination(isPresented: $vm.isAuthenticated) {
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct EventoriasLogo: View {
    var body: some View {
        ZStack {
            VStack {
                Image("eventoriasLogo")
                    .resizable()
                    .frame(width: 70, height: 70)
                Spacer()
                Image("nomLogo")
                    .resizable()
                    .frame(width: 240, height: 20)
            }
            .frame(maxHeight: 120)
        }
    }
}

struct CustomButton: View {
    let label: String
    let iconName: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: iconName)
                .foregroundColor(.white)
            Text(label)
        }
        .padding()
        .frame(
            maxWidth: 240,
            alignment: .init(horizontal: .center, vertical: .center)
        )
        .foregroundColor(.white)
        .background(Color(.customRed))
        .cornerRadius(5)
    }
}

#Preview("AuthView") {
    AuthView(vm: .init(isAuthenticated: false, errorMessage: nil, authService: AuthService()))
}

#Preview("CustomButton") {
    CustomButton(label: "Sign in with Mail", iconName: "Mail")
}
