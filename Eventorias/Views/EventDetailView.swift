//
//  EventDetailView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    let event: Event
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .ignoresSafeArea()
            VStack (spacing: 30) {
                Image(event.cover)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 360)
                    .frame(maxHeight: 360)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(event.date)
                        }
                        HStack {
                            Image(systemName: "clock")
                            Text(event.time)
                        }
                    }
                    .font(.headline)
                    Spacer()
                    Image(event.avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                }
                .font(.subheadline)
                Text(event.description)
                    .font(.subheadline)
                HStack {
                    Text(event.address)
                        .font(.headline)
                        .frame(maxWidth: 170, maxHeight: 70)
                    Spacer()
                    Map(
                        initialPosition: .region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: 48.864716,
                                    longitude: 2.349014
                                ),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.01,
                                    longitudeDelta: 0.01
                                )
                            )
                        ), interactionModes: []
                    )
                    .frame(maxWidth: 150, maxHeight: 70)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle(event.title)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbarColorScheme(ColorScheme.dark)
        .background(Color(.customColorBackground))
        .foregroundStyle(Color(.customWhite))
    }
}

#Preview {
    let event = Event(title: "Music festival", date: "June 15, 2024", avatar: "avatar", cover: "imageEvent", description: "Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks.", address: "123 Rue de l'Art, Quartier des Galeries, Paris, 75003, France", time: "10:00 AM")
    EventDetailView(event: event)
}


