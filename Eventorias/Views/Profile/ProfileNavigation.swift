//
//  ProfileNavigation.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct ProfileNavigation: View {
    let profileVM: ProfileViewModel
    var body: some View {
        NavigationStack {
            ProfileView(profileVM: profileVM)
                .background(Color(.customColorBackground))
        }
    }
}


