//
//  MainTabView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct MainTabView: View {
    @State var EventVM = EventViewModel()
    @State var ProfileVM = ProfileViewModel()
    var body: some View {
        TabView {
            EventsNavigation(EventVM: EventVM)
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }

            ProfileNavigation(ProfileVM: ProfileVM)
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
