//
//  MainTabView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct MainTabView: View {
    
    @State var eventVM = EventViewModel(repository: EventRepository())
    @State var profileVM = ProfileViewModel(profileService: ProfileService())
    
    var body: some View {
        TabView {
            EventsNavigation(eventVM: eventVM)
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }

            ProfileNavigation(profileVM: profileVM)
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
