//
//  MainTabView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

@MainActor
struct MainTabView: View {
    
    @State var EventVM = EventViewModel(repository: EventRepository())
    @State var ProfileVM = ProfileViewModel(profileService: ProfileService())
    
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
