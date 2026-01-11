//
//  RootView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 03/01/2026.
//

import SwiftUI

struct RootView: View {
    let authVM: AuthViewModel

    var body: some View {
        if authVM.isAuthenticated {
            MainTabView()
        } else {
            AuthView(vm: authVM)
        }
    }
}

