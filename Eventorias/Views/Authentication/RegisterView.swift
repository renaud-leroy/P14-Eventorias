//
//  RegisterView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 02/01/2026.
//

import SwiftUI

struct RegisterView: View {
    @Bindable var vm: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .edgesIgnoringSafeArea(.all)
                .accessibilityHidden(true)
            VStack(spacing: 20) {
                Text("Register")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.customWhite)
                    .padding(30)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("Créer un compte")
                FormField(label: "Email", placeholder: "", isSecureTextEntry: false, text: $email)
                    .accessibilityLabel("Adresse e-mail")
                    .accessibilityHint("Champ obligatoire")
                FormField(label: "Password", placeholder: "", isSecureTextEntry: true, text: $password)
                    .accessibilityLabel("Mot de passe")
                    .accessibilityHint("Champ obligatoire")
                FormField(label: "Confirmation", placeholder: "", isSecureTextEntry: true, text: $vm.confirmPassword)
                    .accessibilityLabel("Confirmation du mot de passe")
                    .accessibilityHint("Doit correspondre au mot de passe")
                Button {
                   Task {
                        await vm.register(email: email, password: password)
                    }
                } label: {
                    CustomButton(label: "Sign Up", iconName: "person.badge.plus")
                        .padding(20)
                }
                .accessibilityLabel("Créer le compte")
                .accessibilityHint("Valide l'inscription")
                HStack {
                    Text("Have an account")
                        .foregroundStyle(.customColorTextForm)
                        .font(.caption)
                        .accessibilityLabel("Vous avez déjà un compte")
                    Button {
                        dismiss()
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(.customRed)
                            .font(.caption)
                    }
                    .accessibilityLabel("Se connecter")
                    .accessibilityHint("Retour à l'écran de connexion")
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView(vm: AuthViewModel(isAuthenticated: false, authService: AuthService()))
}
