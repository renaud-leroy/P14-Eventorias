//
//  AuthView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct AuthView: View {
    @State private var showMain: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    EventoriasLogo()
                        .padding(.top, 150)
                        .padding(.bottom, 50)
                    Button {
                        showMain = true
                    } label: {
                        SignInButton(title: "Sign in with Mail", iconName: "Mail")
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.customColorBackground))
            .navigationDestination(isPresented: $showMain) {
                MainTabView()
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

struct SignInButton: View {
    let title: String
    let iconName: String
    var body: some View {
        HStack(spacing: 25) {
            Image("mailIcon")
                .foregroundColor(.white)
            Text(title)
        }
        .padding()
        .frame(
            maxWidth: 240,
            alignment: .init(horizontal: .leading, vertical: .center)
        )
        .foregroundColor(.white)
        .background(Color(.customRed))
        .cornerRadius(5)
    }
}

#Preview("AuthView") {
    AuthView()
}

#Preview("SignInButton") {
    SignInButton(title: "Sign in with Mail", iconName: "Mail")
}
