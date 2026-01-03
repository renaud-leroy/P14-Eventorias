//
//  EventListView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct EventListView: View {
    let vm: EventViewModel
    @State private var isShowingCreateEvent = false
    @State private var searchQuery: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                TextField("", text: $searchQuery)
            }
            .foregroundStyle(.customWhite)
            .padding(.horizontal, 12)
            .frame(height: 35)
            .background(Color(.customGrey))
            .cornerRadius(35)
            Button {
                // action de tri à ajouter
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Sorting")
                }
                .frame(maxWidth: 105, maxHeight: 35)
                .font(.subheadline)
                .foregroundColor(.white)
                .background(Color(.customGrey))
                .cornerRadius(35)
            }

            List {
                ForEach(vm.eventsList, id: \.title) { event in
                    NavigationLink {
                        EventDetailView(event: event)
                    } label: {
                        EventRow(event: event)
                    }
                    .listRowInsets(EdgeInsets(
                        top: 8,
                        leading: 0,
                        bottom: 8,
                        trailing: 0
                    ))
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .navigationLinkIndicatorVisibility(.hidden)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.customColorBackground)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingCreateEvent = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.customWhite)
                }
            }
        }
        .sheet(isPresented: $isShowingCreateEvent) {
            CreateEventView()
        }
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
