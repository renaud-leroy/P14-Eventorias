//
//  ProfileNavigation.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct ProfileNavigation: View {
    let ProfileVM: ProfileViewModel
    var body: some View {
        NavigationStack {
            ProfileView(ProfileVM: ProfileVM)
                .background(Color(.customColorBackground))
        }
    }
}


