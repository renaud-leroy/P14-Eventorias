//
//  RootView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 03/01/2026.
//

import SwiftUI

struct RootView: View {
    let AuthVM: AuthViewModel

    var body: some View {
        if AuthVM.isAuthenticated {
            MainTabView()
        } else {
            AuthView(vm: AuthVM)
        }
    }
}

