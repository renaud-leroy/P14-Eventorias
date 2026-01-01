//
//  MainTabView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            EventsNavigation(vm: EventViewModel())
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }

            ProfileNavigation()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.customRed)
    }
}

#Preview {
    MainTabView()
}
