//
//  AuthView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct AuthView: View {
    @Bindable var vm: AuthViewModel
    @State private var isShowingRegisterSheet: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image("logoEventorias")
                        .accessibilityHidden(true)
                        .padding(.top, 130)
                        .padding(.bottom, 50)
                    FormField(label: "Email",
                              placeholder: "",
                              isSecureTextEntry: false,
                              text: $email)
                    .accessibilityLabel("Adresse e-mail")
                    .accessibilityHint("Champ obligatoire")
                    .frame(maxWidth: 300)
                    .textInputAutocapitalization(.never)
                    FormField(label: "Password",
                              placeholder: "",
                              isSecureTextEntry: true,
                              text: $password)
                    .accessibilityLabel("Mot de passe")
                    .accessibilityHint("Champ obligatoire")
                    .frame(maxWidth: 300)
                    Button {
                        Task {
                            await vm.login(email: email, password: password)
                        }
                    } label: {
                        CustomButton(label: "Sign in with Mail", iconName: "envelope.fill")
                            .padding(30)
                    }
                    .accessibilityLabel("Se connecter avec une adresse e-mail")
                    .accessibilityHint("Lance la connexion")
                    Divider()
                        .accessibilityHidden(true)
                        .background(Color(.customColorTextForm))
                        .frame(maxWidth: 300)
                        .padding(.bottom, 30)
                    Text("No account? Sign up")
                        .accessibilityLabel("Vous n'avez pas de compte")
                        .foregroundStyle(.customColorTextForm)
                        .font(.caption)
                    Button {
                        isShowingRegisterSheet = true
                    } label: {
                        CustomButton(label: "Sign Up", iconName: "person.badge.plus")
                            .padding(10)
                    }
                    .accessibilityLabel("Créer un compte")
                    .accessibilityHint("Ouvre l'écran d'inscription")
                    Spacer()
                        .accessibilityHidden(true)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.customColorBackground))
        }
        .sheet(isPresented: $isShowingRegisterSheet) {
            RegisterView(vm: vm)
        }
        .errorAlert(message: $vm.errorMessage)
    }
}


struct EventoriasLogo: View {
    var body: some View {
        ZStack {
            VStack {
                Image("eventoriasLogo")
                    .resizable()
                    .accessibilityHidden(true)
                    .frame(width: 70, height: 70)
                Spacer()
                Image("nomLogo")
                    .resizable()
                    .accessibilityHidden(true)
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
                .accessibilityHidden(true)
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
