//
//  RootView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 03/01/2026.
//

import SwiftUI

struct RootView: View {
    let vm: AuthViewModel

    var body: some View {
        if vm.isAuthenticated {
            MainTabView()
        } else {
            AuthView(vm: vm)
        }
    }
}

