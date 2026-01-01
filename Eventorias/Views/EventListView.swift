//
//  EventListView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct EventListView: View {
    let vm: EventViewModel
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach (vm.eventsList, id: \.title) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventRow(event: event)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let sampleEvents: [Event] = [
        Event(
            title: "Music Festival",
            date: "June 15, 2024",
            avatar: "avatar",
            cover: "imageEvent",
            description: "Join us for an exclusive music festival.",
            address: "123 Music Street, Paris",
            time: "18:00"
        ),
        Event(
            title: "Art Exhibition",
            date: "July 3, 2024",
            avatar: "avatar",
            cover: "imageEvent",
            description: "Discover modern and classical art.",
            address: "45 Gallery Road, Paris",
            time: "10:00"
        ),
        Event(
            title: "Tech Conference",
            date: "August 21, 2024",
            avatar: "avatar",
            cover: "imageEvent",
            description: "A conference about the latest tech trends.",
            address: "99 Innovation Ave, Paris",
            time: "09:00"
        ),
        Event(
            title: "Food Market",
            date: "September 1, 2024",
            avatar: "avatar",
            cover: "imageEvent",
            description: "Street food from all around the world.",
            address: "Central Park, Paris",
            time: "12:00"
        )
    ]
    EventListView(vm: EventViewModel())
}
